import 'package:flutter/material.dart';
import 'package:flutter_food/pages/food/food_page.dart';
import 'package:flutter_food/pages/login/login_page.dart';
import 'package:flutter_food/pages/profile/profile_page.dart';
import 'package:flutter/foundation.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _subPageIndex = 0;
  var _selectedDrawerItemIndex = 0;
  final _pageDataList = [
    {
      'icon': Icons.fastfood,
      'title': 'Food',
      'page': foodPage(),
    },
    {
      'icon': Icons.person,
      'title': 'Profile',
      'page': profilePage(),
    },
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_pageDataList[_selectedDrawerItemIndex]['title'] as String),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.red,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(40.0),
                      child: Container(
                        width: 50.0,
                        height: 50.0,
                        child: Image.asset('assets/images/profile.jpg'),
                      )),
                  Text(
                    'Patthamaporn Euamaneerattanagul',
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
                  ),
                  Text('euamaneerattana_p@silpakorn.edu'),
                ],
              ),
            ),
            for (var item in _pageDataList)
              ListTile(
                title: Row(
                  children: [
                    Icon(
                      item['icon'] as IconData,
                      color: item == _pageDataList[_selectedDrawerItemIndex]
                          ? Theme.of(context).accentColor
                          : null,
                    ),
                    SizedBox(width: 8.0),
                    Text(item['title'] as String),
                  ],
                ),
                onTap: () {
                  setState(() {
                    _selectedDrawerItemIndex =
                        _pageDataList.indexWhere((element) => item == element);
                  });
                  Navigator.of(context).pop();
                },
                selected: item == _pageDataList[_selectedDrawerItemIndex],
              ),
          ],
        ),
      ),
      body: Container(
        child: _pageDataList[_selectedDrawerItemIndex]['page'] as Widget,
      ),
    );
  }
}
