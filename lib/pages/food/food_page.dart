import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';
import 'package:flutter_food/pages/food/food_list_page.dart';
import 'package:http/http.dart' as http;
class foodPage extends StatefulWidget {
  const foodPage({Key? key}) : super(key: key);

  @override
  _foodPageState createState() => _foodPageState();
}

class _foodPageState extends State<foodPage> {
  @override
  var _selectedBottomNavIndex = 0;

  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Your Order',
          ),
        ],
        currentIndex: _selectedBottomNavIndex,
        onTap: (index) {
          setState(() {
            _selectedBottomNavIndex = index;
          });
        },
      ),
      body: _selectedBottomNavIndex == 0
          ? FoodListPage()
          : Container(
              child: Center(
                child: Text('YOUR ORDER',
                    style: Theme.of(context).textTheme.headline1),
              ),
            ),
    );
  }
  Future<void> _test() async {
    var url = Uri.parse("https://cpsu-test-api.herokuapp.com/foods");
    var response = await http.get(url);
    //var response = await http.post(url,body:{
    //'pin' : '123456'
    //});

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonBody = json.decode(response.body);
      String status = jsonBody['status'];
      String? message = jsonBody['message'];
      List<dynamic> data = jsonBody['data'];

      print('STATUS: $status');
      print('MESSAGE: $message');
      //print('data: $data');

      var foodList = data.map((element) => FoodItem(
        id: element['id'],
        name: element['name'],
        price: element['price'],
        image: element['image'],
      )).toList();

      /* data.forEach((element) {
      FoodItem(
        id: element['id'],
        name:  element['name'],
        price: element['price'],
        image: element['image'],


      );
      });*/

    }
  }
}
