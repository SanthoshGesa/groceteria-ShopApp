import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:store/controller/profile.dart';
import 'package:store/screens/login.dart';
import 'package:store/screens/tabs.dart';

class AuthController extends GetxController {
  FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileController _profileController = Get.put(ProfileController());

  var isUserLoggedIn = false.obs;

  @override
  void onInit() {
    super.onInit();
    validate();
  }

  validate() {
    _auth.authStateChanges().listen((user) {
      if (user != null) {
        isUserLoggedIn.value = true;
        _profileController.readStoreDetails();
        print(_profileController.readStoreDetails());
      } else {
        isUserLoggedIn.value = false;
      }
    });
  }

  login(email, password) {
    email = email.trim().toLowerCase();
    password = password;
    _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value);
      Get.offAll(() => TabsScreen());
    }).catchError((e) {
      print(e);
      Get.showSnackbar(GetBar(
        message: "${e.toString()}",
        duration: Duration(seconds: 3),
      ));
    });
  }

  logout() {
    _auth.signOut().then((value) {
      Get.offAll(() => LoginScreen());
    }).catchError((e) {
      print(e);
    });
  }
}
