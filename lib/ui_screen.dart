import 'package:firebaseanalytic/post_screen.dart';
import 'package:firebaseanalytic/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class uiScreen extends StatelessWidget {
  const uiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Firebase Crud',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SafeArea(
              child: Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Hello ",
                    style: TextStyle(
                        color: Colors.deepPurple,
                        fontStyle: FontStyle.italic,
                        fontSize: 35,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'EveryOne!',
                    style: TextStyle(
                      color: Colors.blueGrey,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Text(
                    'Who am I ?',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.bold,
                      fontSize: 30,
                    ),
                  ),
                  Image.asset(
                    "assets/what_is_crud_2.jpeg",
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  roundButton(
                      title: "Go to Crud",
                      loading: true,
                      onTAp: (() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => postScreen()));
                      }))
                ]),
          )),
        ));
  }
}
