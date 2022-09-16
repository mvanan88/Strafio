import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:strafio/utils/FireAuth.dart';
import '../providers/LoginProvider.dart';
import '../utils/AppColors.dart';
import '../utils/customm_button.dart';
import '../utils/navigation.dart';
import 'SendOTP.dart';
import 'Signup.dart';

var formkey = GlobalKey<FormState>();

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => LoginState();

}
class LoginState extends State<LoginScreen> {
  var emailTextController= TextEditingController();

  var passwordTextController= TextEditingController();
  var mobileTextController= TextEditingController();

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
    return ChangeNotifierProvider(create: (context) => LoginProvider(),
        child: Consumer<LoginProvider>(
        builder: (context,provider,_){
          return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppColors.colorPrimary,
          body:FutureBuilder(
            future: _initializeFirebase(),
            builder: (context,snapshot){
              if (snapshot.connectionState == ConnectionState.done) {
                return Padding(padding: EdgeInsets.only(top:(MediaQuery.of(context).size.height/4) ),
                    child: SingleChildScrollView(
                      child: Container(
                        height: (MediaQuery.of(context).size.height/4)*3,
                        decoration: BoxDecoration(
                            color: AppColors.colorSecondary,
                            boxShadow:<BoxShadow>[
                              BoxShadow(color: AppColors.colorPrimary)
                            ],
                            border: Border.all(color: AppColors.login_bg,width: 1),
                            borderRadius: BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(0))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(padding: EdgeInsets.fromLTRB(16,30,16,16),
                              child : provider.mode == 1 ? Column(
                                key: formkey,
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset("assets/images/logo/logo.svg", height: 30, width: 30,),
                                  Text('Login with Email',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
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
                              ) : Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SvgPicture.asset("assets/images/logo/logo.svg", height: 30, width: 30,),
                                  Text('Login with Phone',style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),),
                                  SizedBox(height: 20,),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/10,
                                        child: TextFormField(style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                                          decoration: const InputDecoration(
                                            labelText: "+91",
                                            border: OutlineInputBorder(),
                                          ),
                                          readOnly: true,
                                        ),
                                      ),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width/10*8,
                                        child:TextFormField(style: TextStyle(fontSize: 14,fontWeight: FontWeight.w400),
                                          controller: mobileTextController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: "0000000000",
                                            border: OutlineInputBorder(),
                                          ),
                                            inputFormatters: [
                                              LengthLimitingTextInputFormatter(10),
                                            ],
                                          validator: (String? value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Please enter Mobile Number';
                                            }
                                            return null;
                                          },
                                        ) ,
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20,),
                                  CustomButton(
                                    title: "Send OTP",
                                    clickButton: () {
                                      // if (formkey.currentState!.validate()) {
                                      // FireAuth.signInUsingEmailPassword(email: emailTextController.text, password: passwordTextController.text, context: context);
                                      // }
                                      Navigator.push(context, MaterialPageRoute(
                                          builder: (context) => SendOTP(
                                            id: mobileTextController.text,
                                          )
                                      )
                                      );
                                    },
                                    width: double.infinity,
                                  ),
                                ],
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
                                        child: Center(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SvgPicture.asset(
                                                "assets/images/logo/google_signin.svg",
                                              ),
                                              Text('Google',textAlign: TextAlign.center,)
                                            ],
                                          ),
                                        )
                                      ),InkWell(
                                        onTap: ()=> FireAuth.signInWithFacebook(),
                                          child: Center(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/logo/facebook_signin.svg",
                                                ),
                                                Text('Facebook',textAlign: TextAlign.center)
                                              ],
                                            ),
                                          )
                                      ),InkWell(
                                        onTap: ()=> setState(() {
                                          provider.mode = provider.mode == 1 ? 0 : 1;
                                        }),
                                            // FireAuth.signInWithGoogle(context: context),
                                        child: provider.mode == 0 ? Center(
                                          child:Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/logo/email_signin.svg",
                                                ),
                                                Text('Email',textAlign: TextAlign.center)
                                              ]
                                          ) ,
                                        )  : Center(
                                          child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/logo/mobile_signin.svg",
                                                ),
                                                Text('Phone No',textAlign: TextAlign.center)
                                              ]
                                          ),
                                        )
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
                                            text: ' Sign Up',
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
                      ),
                    )
                );
              }
              return CircularProgressIndicator();
            } ,
          )
      );
    }
  ),
  );

  }

}