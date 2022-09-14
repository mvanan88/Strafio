
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strafio/utils/FireAuth.dart';
import '../utils/AppColors.dart';
import '../utils/customm_button.dart';
import '../utils/navigation.dart';
import 'Signup.dart';

var formkey = GlobalKey<FormState>();

class LoginScreen extends StatelessWidget {
  var emailTextController= TextEditingController();

  var passwordTextController= TextEditingController();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // navigation.replaceScreen();
    }
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
      body:FutureBuilder(
        future: _initializeFirebase(),
        builder: (context,snapshot){
          if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            child:Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/3,
                  decoration: BoxDecoration(
                      color: AppColors.colorPrimary,
                  )
                ),
                Padding(padding: EdgeInsets.fromLTRB(16, (MediaQuery.of(context).size.height/4), 16, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width-30,
                        height: MediaQuery.of(context).size.height/2,
                        decoration: BoxDecoration(
                            color: AppColors.colorSecondary,
                            boxShadow:<BoxShadow>[
                              BoxShadow(color: AppColors.colorPrimary)
                            ],
                            border: Border.all(color: AppColors.login_bg,width: 1),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(20))),
                        child: Padding(padding: EdgeInsets.all(16),
                        child : Column(
                          key: formkey,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Login',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                            SizedBox(height: 20,),
                            TextFormField(
                              controller: emailTextController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                hintText: "Email",
                                prefixIcon: Icon(Icons.email),
                                border: UnderlineInputBorder()
                              ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Email';
                                } else if (!value.contains("@")) {
                                  return 'Please enter valid Email';
                                } else if (!value.contains(".")) {
                                  return 'Please enter valid Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 10,),
                            TextFormField(
                              controller: passwordTextController,
                              obscureText: true,
                              decoration: const InputDecoration(
                                hintText: "Password",
                                prefixIcon: Icon(Icons.lock),
                                border: UnderlineInputBorder(),
                                ),
                              validator: (String? value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter Password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(height: 20,),
                            CustomButton(
                              title: "Login",
                              clickButton: () {
                                // if (formkey.currentState!.validate()) {
                                  FireAuth.signInUsingEmailPassword(email: emailTextController.text, password: passwordTextController.text, context: context);
                                // }
                              },
                              width: double.infinity,
                            ),
                          ],
                        ),
                        ),
                      ),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 90), child: Align(
                      alignment: Alignment.bottomCenter,
                      child:Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('or login with',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey_timid_text),),
                          SizedBox(height: 30,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: ()=> FireAuth.signInWithGoogle(context: context),
                                child: SvgPicture.asset(
                                  "assets/images/logo/google_signin.svg",
                                ),
                              ),InkWell(
                                onTap: ()=> FireAuth.signInWithFacebook(),
                                child: SvgPicture.asset(
                                  "assets/images/logo/facebook_signin.svg",
                                ),
                              ),InkWell(
                                onTap: ()=> FireAuth.signInWithGoogle(context: context),
                                child: SvgPicture.asset(
                                  "assets/images/logo/mobile_login.svg",
                                ),
                              ),
                            ],
                          )
                        ],
                      ) ,
                    ),
                    ),
                Padding(padding: EdgeInsets.all(10),child: Align(
                  alignment: Alignment.bottomCenter,
                  child:InkWell(
                    onTap: ()=> navigation.replaceScreen(context, Signup()),
                    child: Text.rich(
                        TextSpan(
                            text: "Don't have an account?",
                            children: <InlineSpan>[
                              TextSpan(
                                text: 'Sign In',
                                style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColors.colorPrimary),
                              )
                            ]
                        )
                    ),
                  ) ,
                ),
                )
              ],
            ) ,
          );
        }
         return CircularProgressIndicator();
      } ,
    )
    );

  }

}