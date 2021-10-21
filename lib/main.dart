import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/screens/validate.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: ValidateScreen(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: Colors.green,
          primaryColor: Colors.green),
    );
  }
}
