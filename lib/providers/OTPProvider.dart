import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:strafio/utils/AppPreferences.dart';
import 'package:strafio/utils/KeyConstants.dart';
import 'package:strafio/utils/navigation.dart';

import '../screens/HomeScreen.dart';

class OTPProvider extends ChangeNotifier {

  String authcode = "";
  var _authCredential;
  void sendOtp(String number) async{
    FirebaseAuth auth = FirebaseAuth.instance;

    await auth.verifyPhoneNumber(
      phoneNumber: '+91'+number,
      codeSent: (String verificationId, int? resendToken) async {
        await AppPreferences.saveString(KeyConstants.keyAuthCode, verificationId);
        this.authcode = await verificationId;
        // Update the UI - wait for the user to enter the SMS code
        print(verificationId);
        String smsCode = '';

        // Create a PhoneAuthCredential with the code
        PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
        print(credential);
        // Sign the user in (or link) with the credential
        await auth.signInWithCredential(credential);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        print(verificationId);
      },
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {},
      verificationFailed: (FirebaseAuthException error) {  },
    );
  }

  void signInWithPhoneNumber(String smsCode,BuildContext context) async {
    _authCredential = PhoneAuthProvider.credential(
        verificationId: (await AppPreferences.getValue(KeyConstants.keyAuthCode))!, smsCode: smsCode);
    print((await AppPreferences.getValue(KeyConstants.keyAuthCode))!);
    print(smsCode);
    print(_authCredential);
    FirebaseAuth auth = FirebaseAuth.instance;
    auth.signInWithCredential(_authCredential)
        .then((UserCredential result) async {
     var user = result.user;
      var displayname = "";
      try{
        if(user?.displayName! != null){
          displayname = user!.displayName!;
        }
        await AppPreferences.saveString(KeyConstants.keyName, displayname);
        await AppPreferences.saveString(KeyConstants.keyProfileImage, user?.photoURL!);
      }catch(e){
        print(e);
      }

      print(await AppPreferences.getValue(KeyConstants.keyName));
      print(await AppPreferences.getValue(KeyConstants.keyProfileImage));
      navigation.replaceScreen(context, HomeScreen());
    }).catchError((error) {});
  }
}