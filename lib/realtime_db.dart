import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseanalytic/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class realtime_db extends StatefulWidget {
  const realtime_db({super.key});

  @override
  State<realtime_db> createState() => _realtime_dbState();
}

class _realtime_dbState extends State<realtime_db> {
  late DatabaseReference _dbref;
  String databasejson = "";
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dbref = FirebaseDatabase.instance.ref();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: 'Email',
                          helperText: 'enter email e.g hassaan@gmail.com',
                          suffix: Icon(Icons.alternate_email)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText: 'Password', suffix: Icon(Icons.lock_open)),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Enter Password";
                        }
                        return "Enter Password";
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 30,
              ),

              // Text("database -" + databasejson),
              // TextButton(
              //     onPressed: () {
              //       _createDB();
              //     },
              //     child: Text("create DB")),

              // TextButton(onPressed: () {

              // //  _readdb_once();
              // }, child: Text("read value")),

              // TextButton(onPressed: () {}, child: Text("update value")),
              // TextButton(onPressed: () {}, child: Text("delete value")),
              // roundButton(
              //     title: "Login",
              //     onTAp: (() {
              //       if (_formKey.currentState!.validate()) {}
              //     }), loading: true,),
              // SizedBox(
              //   height: 30,
              // ),
              // Row(
              //   children: [
              //     Text("Don't have an account?"),
              //     TextButton(onPressed: () {}, child: Text("Sign Up"))
              //   ],
              // )
            ]),
      ),
    );
  }

  _createDB() {
    _dbref.child('profile').set("hassaan profile");
    _dbref.child("jobprofile").set({
      'website': "www.blueappsoftware.com",
      "website2": "www.dirpcoding.com"
    });
  }

  // _readdb_once() {
  //   _dbref.once().then((DataSnapshot dataSnapshot) {
  //     print("read once- " +dataSnapshot.value.toString();
  //     setState(() {
  //       databasejson = dataSnapshot.value.toString();
  //     });
  //   });
  // }
  // _realdb_oncechild(){
  //   _dbref.child('jobprofile').child('website2').once().then((DataSnapshot dataSnapshot) {

  //   })
}
