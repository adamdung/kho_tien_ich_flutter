import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Test Firebase'),
        ),
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('sales').snapshots(),
          builder: (context, taskSnapShot) {
            if (!taskSnapShot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
                itemCount: taskSnapShot.data.docs.length,
                itemBuilder: (context, index) {
                  return Dismissible(
                    key: Key(taskSnapShot.data.docs[index].id),
                    onDismissed: (direction) {
                      delete(taskSnapShot.data.docs[index]);
                    },
                    background: Container(
                      color: Colors.red,
                      child: Center(
                          child: Text(
                        'Delele',
                        style: TextStyle(color: Colors.white),
                      )),
                    ),
                    child: ListTile(
                      title: Text(taskSnapShot.data.docs[index]['saleYear']),
                    ),
                  );
                });
          },
        ));
  }

  void delete(taskDocument) {
    FirebaseFirestore.instance
        .collection('todos')
        .doc(taskDocument.id)
        .delete();
  }
}
