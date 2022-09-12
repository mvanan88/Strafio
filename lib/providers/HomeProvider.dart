import 'package:flutter/material.dart';
import 'package:strafio/utils/AppPreferences.dart';
import 'package:strafio/utils/KeyConstants.dart';

class HomeProvider extends ChangeNotifier {

  String username = "";
  String profileImage = "";


  HomeProvider() {
    // setCurrentDate();
    getMyDetails();
    // getCategories();
    // getUpcomingList();
  }

  void getMyDetails() async{
    username = (await AppPreferences.getValue(KeyConstants.keyName))!;
    profileImage = (await AppPreferences.getValue(KeyConstants.keyProfileImage))!;
    notifyListeners();
  }

}
