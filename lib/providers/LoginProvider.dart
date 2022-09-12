
import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  var emailTextController = TextEditingController();
  var passwordTextController = TextEditingController();
  String? email;
  String? password;
  String? error;
  bool isError = false;
  bool passwordVisible = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  LoginProvider() {
    passwordVisible = false;
  }

  passwordVisibility() {
    passwordVisible = !passwordVisible;
    notifyListeners();
  }

  void resetTextField() {
    emailTextController.text = "";
    passwordTextController.text = "";
    email = "";
    password = "";
    error = "";
    notifyListeners();
  }

  // void setDataSharePreferences(ResponseLogin? responseLogin) {
  //   int? userID = responseLogin?.data?.id;
  //   AppPreferences.saveString(
  //       KeyConstants.keyAuthToken, responseLogin?.data?.token);
  //   AppPreferences.saveString(
  //       KeyConstants.keyUserName, responseLogin?.data?.name);
  //   AppPreferences.saveInt(KeyConstants.keyUserId, userID!);
  //   AppPreferences.saveString(
  //       KeyConstants.keyProfileImage, responseLogin?.data?.avatar);
  //   AppPreferences.saveString(KeyConstants.keyName, responseLogin?.data?.name);
  //   AppPreferences.saveBool(
  //       KeyConstants.keyIsAdmin, responseLogin?.data?.isAdmin);
  //   AppPreferences.saveBool(KeyConstants.keyIsHr, responseLogin?.data?.isHr);
  // }

  // void getUserInfo(context) async {
  //   var bodyLogin = BodyLogin(
  //       email: emailTextController.text, password: passwordTextController.text);
  //   var apiResponse = await AuthRepository.getLogin(bodyLogin);
  //   if (apiResponse.result == true) {
  //     getBaseSetting();
  //     setDataSharePreferences(apiResponse.data);
  //     Fluttertoast.showToast(
  //         msg: apiResponse.message ?? "",
  //         toastLength: Toast.LENGTH_SHORT,
  //         gravity: ToastGravity.BOTTOM,
  //         timeInSecForIosWeb: 1,
  //         backgroundColor: Colors.green,
  //         textColor: Colors.white,
  //         fontSize: 12.0);
  //     resetTextField();
  //     _checkGps(context);
  //     Navigator.pushReplacement(
  //         context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //
  //     ///navigation.replaceScreen(context, const ButtomNavigationBar());
  //   } else {
  //     //Navigator.pushReplacement(
  //     //    context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //     if (apiResponse.httpCode == 422) {
  //       email = apiResponse.error?.laravelValidationError?.email;
  //       password = apiResponse.error?.laravelValidationError?.password;
  //       error = apiResponse.message;
  //       notifyListeners();
  //     } else if (apiResponse.httpCode == 400) {
  //       email = apiResponse.error?.laravelValidationError?.email;
  //       password = apiResponse.error?.laravelValidationError?.password;
  //       error = apiResponse.message;
  //       notifyListeners();
  //     } else {
  //       Fluttertoast.showToast(msg: "Something Went Wrong");
  //     }
  //   }
  // }

  // void ForgotpasswordNavigation(BuildContext context) async {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const ForgetPassword()),
  //   );
  //   notifyListeners();
  // }

  // getBaseSetting() async {
  //   var apiResponse = await Repository.baseSettingApi();
  //   if (apiResponse.result == true) {
  //     notifyListeners();
  //   }
  // }
}
