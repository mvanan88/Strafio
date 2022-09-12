
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strafio/screens/LoginScreen.dart';
import 'package:strafio/utils/FireAuth.dart';
import '../utils/AppColors.dart';
import '../utils/customm_button.dart';
import '../utils/navigation.dart';

var formkey = GlobalKey<FormState>();

class Signup extends StatelessWidget {
  var emailTextController= TextEditingController();
  var firstNameController= TextEditingController();
  var lastNameController= TextEditingController();
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

                          borderRadius: BorderRadius.vertical(
                              top: Radius.circular(0),
                              bottom: Radius.circular(20))),
                    ),
                    Padding(padding: EdgeInsets.fromLTRB(16, (MediaQuery.of(context).size.height/4), 16, 0),
                      child: Container(
                        width: MediaQuery.of(context).size.width-30,
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('Sign Up',style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                              SizedBox(height: 20,),
                              TextFormField(
                                controller: firstNameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "First Name",
                                  prefixIcon: Icon(Icons.person),
                                  border: UnderlineInputBorder()
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter First Name';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                controller: lastNameController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: "Last Name",
                                  prefixIcon: Icon(Icons.person),
                                  border: UnderlineInputBorder()
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Last Name';
                                  }
                                  return null;
                                },
                              ),
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
                                obscureText: true,
                                controller: passwordTextController,textAlign: TextAlign.start,
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(Icons.lock),
                                  border: UnderlineInputBorder()
                                ),
                                validator: (String? value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter Password';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 10,),

                              SizedBox(height: 20,),
                              CustomButton(
                                title: ("Sign Up"),
                                clickButton: () {
                                  // if (formkey.currentState!.validate()) {
                                  FireAuth.signUpUsingEmailPassword(email: emailTextController.text, password: passwordTextController.text, context: context);
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
                          Text('or ',style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.grey_timid_text),),
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
                        onTap: ()=> navigation.replaceScreen(context, LoginScreen()),
                        child: Text.rich(
                            TextSpan(
                                text: "Already Signed up?",
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: 'Login',
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