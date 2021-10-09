import 'package:flutter/material.dart';

class profilePage extends StatelessWidget {
  const profilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(40.0),
                  child: Container(
                    width: 80.0,
                    height: 80.0,
                    child: Image.asset('assets/images/profile.jpg'),
                  )),
              Text("Patthamaporn Euamaneerattanagul"),
              Text("euamaneerattana_p@silpakorn.edu"),
            ],
          ),
        ),
      ),
    );
  }
}
