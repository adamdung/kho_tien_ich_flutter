import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:kho_tien_ich_flutter/chart/pages/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      // home: HomePage(),
    );
  }
}
