import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebaseanalytic/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:firebase_database/firebase_database.dart';

class postScreen extends StatefulWidget {
  const postScreen({super.key});

  @override
  State<postScreen> createState() => _postScreenState();
}

class _postScreenState extends State<postScreen> {
  final ref = FirebaseDatabase.instance.ref('post');
  final sreachFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Post"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextFormField(
                controller: sreachFilter,
                decoration: InputDecoration(
                    hintText: "Searching...", border: OutlineInputBorder()),
                onChanged: ((String value) {
                  setState(() {});
                }),
              ),
            ),
            Expanded(
              child: FirebaseAnimatedList(
                  query: ref,
                  defaultChild: Text('Loading..'),
                  itemBuilder: (context, snapshot, animation, index) {
                    final title = snapshot.child('title').value.toString();

                    if (sreachFilter.text.isEmpty) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                        trailing: PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            itemBuilder: (context) => [
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        Navigator.pop(context);
                                        showMyDialog(
                                            title,
                                            snapshot
                                                .child('id')
                                                .value
                                                .toString());
                                      },
                                      leading: Icon(Icons.edit),
                                      title: Text('Edit'),
                                    ),
                                  ),
                                  PopupMenuItem(
                                    value: 1,
                                    child: ListTile(
                                      onTap: () {
                                        ref
                                            .child(snapshot
                                                .child('id')
                                                .value
                                                .toString())
                                            .remove();
                                      },
                                      leading: Icon(Icons.delete),
                                      title: Text('Delete'),
                                    ),
                                  ),
                                ]),
                      );
                    } else if (title.toLowerCase().contains(
                        sreachFilter.text.toLowerCase().toLowerCase())) {
                      return ListTile(
                        title: Text(snapshot.child('title').value.toString()),
                        subtitle: Text(snapshot.child('id').value.toString()),
                      );
                    } else {
                      return Container();
                    }
                  }),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (() {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => addPostScreen()));
          }),
          child: Icon(Icons.add),
          backgroundColor: Colors.deepPurple,
        ));
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
        barrierColor: Colors.deepPurple,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Update'),
            content: Container(
                child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'Edit'),
            )),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ref.child(id).update({
                      'title': editController.text.toLowerCase()
                    }).then((value) {
                      print("Post update");
                    }).onError((error, stackTrace) {
                      return showDialog(
                          context: context,
                          builder: ((context) {
                            return Text('this rong');
                          }));
                    });
                  },
                  child: Text('Update'))
            ],
          );
        });
  }
}
//  Expanded(
//               child: StreamBuilder(
//                   stream: ref.onValue,
//                   builder: ((context, AsyncSnapshot<DatabaseEvent> snapshot) {
//                     if (snapshot.hasData) {
//                       return CircularProgressIndicator();
//                     } else {
//                       Map<dynamic, dynamic> map =
//                           snapshot.data?.snapshot.value as dynamic;
//                       List<dynamic> list = [];
//                       list.clear();
//                       list = map.values.toList();
//                       return ListView.builder(
//                         itemCount: snapshot.data?.snapshot.children.length,
//                         itemBuilder: (context, index) {
//                           return ListTile(
//                             title: Text(list[index]['title']),
//                             leading: Text(list[index]['id']),
//                           );
//                         },
//                       );
//                     }
//                   })),
//             ),
