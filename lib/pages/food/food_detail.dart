import 'package:flutter/material.dart';
import 'package:flutter_food/models/food_item.dart';

class FoodDetail extends StatefulWidget {
  static const routeName = '/detail';
  const FoodDetail({Key? key}) : super(key: key);

  @override
  _FoodDetailState createState() => _FoodDetailState();
}

class _FoodDetailState extends State<FoodDetail> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as FoodItem;
    return Scaffold(
      appBar: AppBar(
        title: Text(args.name),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              "assets/images/${args.image}",
            ),
            Text("ชื่อเมนู: ${args.name}"),
            Text("ราคา: ${args.price}"),
          ],
        ),
      ),
    );
  }
}
