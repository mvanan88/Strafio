import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:strafio/screens/Home.dart';
import 'package:strafio/screens/HomeScreen.dart';
import 'package:strafio/utils/AppPreferences.dart';
import 'package:strafio/utils/KeyConstants.dart';
import 'package:strafio/utils/Resource.dart';
import 'package:strafio/utils/navigation.dart';

class FireAuth {
  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }
  static Future<User?> signUpUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      user = userCredential.user;
      var displayname = "";
      if(user?.displayName! != null){
        displayname = user!.displayName!;
      }
      await AppPreferences.saveString(KeyConstants.keyName, displayname);
      await AppPreferences.saveString(KeyConstants.keyProfileImage, user?.photoURL!);
      print(user?.displayName);
      print(await AppPreferences.getValue(KeyConstants.keyName));
      print(await AppPreferences.getValue(KeyConstants.keyProfileImage));
      navigation.replaceScreen(context, HomeScreen());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
        var displayname = "";
        if(user?.displayName! != null){
          displayname = user!.displayName!;
        }
        await AppPreferences.saveString(KeyConstants.keyName, displayname);
        await AppPreferences.saveString(KeyConstants.keyProfileImage, user?.photoURL!);
        print(user?.displayName);
        print(await AppPreferences.getValue(KeyConstants.keyName));
        print(await AppPreferences.getValue(KeyConstants.keyProfileImage));
        navigation.replaceScreen(context, HomeScreen());
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }

    return user;
  }

 static Future<Resource?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);
      switch (result.status) {
        case LoginStatus.success:
          final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(result.accessToken!.token);
          final userCredential = await FirebaseAuth.instance.signInWithCredential(facebookCredential);
          return Resource(status: Status.Success);
        case LoginStatus.cancelled:
          return Resource(status: Status.Cancelled);
        case LoginStatus.failed:
          return Resource(status: Status.Error);
        default:
          return null;
      }
    } on FirebaseAuthException catch (e) {
      throw e;
    }
  }

  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    final GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut();
  }


}