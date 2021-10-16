import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_food/pages/home/home_page.dart';
import 'package:http/http.dart' as http;


class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var input = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            // ไล่เฉดจากมุมบนซ้ายไปมุมล่างขวาของ Container
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            // ไล่เฉดจากสีแดงไปสีน้ำเงิน
            colors: [
              Colors.greenAccent.shade100,
              Colors.blue.shade100,
              Colors.cyanAccent,
              //Colors.pinkAccent.shade100,
              //Colors.purpleAccent.shade100,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.lock_outline,
                        size: 100.0,
                      ),
                      Text(
                        "LOGIN",
                        style: Theme.of(context).textTheme.headline1,
                      ),
                      Text("Enter PIN to login"),
                      Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var j = 0; j < input.length; j++)
                              Icon(
                                Icons.circle,
                                size: 30.0,
                                color: Colors.blueGrey,
                              ),
                            for (var i = 0; i < 6 - input.length; i++)
                              Icon(
                                Icons.circle,
                                size: 30.0,
                                color: Colors.blueGrey.shade50,
                              ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                //color: Colors.pink,
                child: Column(
                    children: [
                  // for(var row =0;row<3;row++)
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     for(var col =1;col<=3;col++)
                  //     LoginButton(number: row*3 + col,),
                  [1, 2, 3],
                  [4, 5, 6],
                  [7, 8, 9],
                  [-2, 0, -1],
                ].map((row) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: row.map((item) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: LoginButton(
                          number: item,
                          onClick: _handleClickButton,
                        ),
                      );
                    }).toList(),
                  );
                }).toList()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleClickButton(int num) {
    setState(() {
      if (input.length > 0 && num == -1) {
        input = input.substring(0, input.length - 1);
      } else if (num != -1) {
        input = "$input$num";
      }
      if (input.length == 6) {
        //call api
        _test(input);

        // data -- boolean


        /*if (input == pin) {//change if
          */ /*Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );*/ /*
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }*/ /* else {
          _showMaterialDialog('ERROR', 'Invalid PIN. Please try again.');
        }*/

        input = '';
      }
    });
  }
        Future<void> _test(String pin) async {
      var url = Uri.parse("https://cpsu-test-api.herokuapp.com/login");
      var response = await http.post(url, body: {
        'pin': pin
      });

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonBody = json.decode(response.body);
        String status = jsonBody['status'];
        String? message = jsonBody['message'];
        bool data = jsonBody['data'];

        print('STATUS: $status');
        print('MESSAGE: $message');
        print('data: $data');

        if (data == false) {
          _showMaterialDialog('ERROR', 'Invalid PIN. Please try again.');
        } else {
          Navigator.pushReplacementNamed(context, HomePage.routeName);
        }
      }
    }

  void _showMaterialDialog(String title, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            // ปุ่ม OK ใน dialog
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                // ปิด dialog
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  final int number;
  final Function(int) onClick;

  const LoginButton({
    required this.number,
    required this.onClick,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      customBorder: CircleBorder(),
      onTap: number == -2 ? null : () => onClick(number),
      child: Container(
        width: 80.0,
        height: 80.0,
        decoration: number == -2
            ? null
            : BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 2.0),
              ),
        child: Center(
          child: number >= 0
              ? Text(
                  "$number",
                  style: Theme.of(context).textTheme.headline6,
                )
              : (number == -1
                  ? Icon(
                      Icons.backspace_outlined,
                      size: 28.0,
                    )
                  : SizedBox.shrink()),
        ),
      ),
    );
  }
}
