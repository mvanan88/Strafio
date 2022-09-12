
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:strafio/screens/HomeScreen.dart';
import 'package:strafio/utils/FireAuth.dart';
import '../screens/LoginScreen.dart';
import '../screens/WalkThrough.dart';
import '../utils/AppPreferences.dart';
import '../utils/KeyConstants.dart';
import '../utils/navigation.dart';

class SplashProvider extends ChangeNotifier{
  // bool isValid = false;
  SplashProvider(context){
    // getToken(context);
    initFunction(context);
  }

  initFunction(context){
    Future.delayed(const Duration(seconds: 4), () async {
      if (kDebugMode) {
        /// development purpose only
        // print("User Id: $userId");
      }
      try{
        if (await FirebaseAuth.instance.currentUser != null) {
          navigation.replaceScreen(context, HomeScreen());
        } else {
          print("Inside Else");
          navigation.replaceScreen(context, WalkThrough());
        }
      }on NullThrownError catch(_){
        print("Inside Catch");
        navigation.replaceScreen(context, WalkThrough());
      }
      notifyListeners();
    });
  }
}