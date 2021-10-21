import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store/controller/authentication.dart';

import 'package:store/screens/login.dart';
import 'package:store/screens/tabs.dart';

class ValidateScreen extends StatelessWidget {
  AuthController _auth = Get.put(AuthController());
  // bool _isUserLoggedIn = false;

  // validate() {
  //   _auth.authStateChanges().listen((user) {
  //     if (user != null) {
  //       setState(() {
  //         _isUserLoggedIn = true;
  //       });
  //     } else {
  //       setState(() {
  //         _isUserLoggedIn = false;
  //       });
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Obx(() => _auth.isUserLoggedIn.value ? TabsScreen() : LoginScreen());
  }
}
