import 'package:firebase_database/firebase_database.dart';
import 'package:firebaseanalytic/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class addPostScreen extends StatefulWidget {
  addPostScreen({super.key});

  @override
  State<addPostScreen> createState() => _addPostScreenState();
}

class _addPostScreenState extends State<addPostScreen> {
  final postController = TextEditingController();

  bool loading = false;
  DatabaseReference database = FirebaseDatabase.instance.ref('post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Add Post"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            TextFormField(
              controller: postController,
              decoration: InputDecoration(
                  hintText: 'What is in your mind?',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 30,
            ),
            roundButton(
                title: 'Add',
                loading: loading,
                onTAp: () {
                  setState(() {
                    loading = true;
                  });
                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  database.child(id).set({
                    "title": postController.text.toString(),
                    "id": id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    print('Post Add');
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                  });
                })
          ],
        ),
      ),
    );
  }
}
