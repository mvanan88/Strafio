
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strafio/providers/OTPProvider.dart';
import 'package:strafio/utils/AppColors.dart';

import '../otpui/OtpTextField.dart';
import '../otpui/style.dart';
import '../utils/customm_button.dart';

class SendOTP extends StatefulWidget{
  const SendOTP({Key? key, required this.id}) : super(key: key);
  final String id;
  @override
  State<SendOTP> createState()  => SendOTPState(id);

}

class SendOTPState extends State<SendOTP>{

  String number;
  String pin="";
  SendOTPState(this.number);
  OtpFieldController otpController = OtpFieldController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
     final auth = Provider.of<OTPProvider>(context, listen: false);
     auth.sendOtp(number);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => OTPProvider(),
        child: Consumer<OTPProvider>(
        builder: (context,provider,_){
      return Scaffold(
          resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.colorSecondary,
        appBar: AppBar(
          backgroundColor: AppColors.colorSecondary,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('Check your Phone', style: TextStyle(color: AppColors.colorPrimary),),
        ),
        body: Container(
          child: Padding(padding: EdgeInsets.all(16),
          child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('We,ve sent a 6-digit confirmation code to '+number+'. Make sure you enter correct code.', style: TextStyle(color: AppColors.grey_timid_text),),
            SizedBox(height: 30,),
            OTPTextField(
                controller: otpController,
                length: 6,
                width: MediaQuery.of(context).size.width,
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldWidth: 50,
                fieldStyle: FieldStyle.box,
                outlineBorderRadius: 15,
                style: TextStyle(fontSize: 17),
                onChanged: (pin) {
                  print("Changed: " + pin);
                },
                onCompleted: (pin) {
                  print("Completed: " + pin);
                  this.pin = pin;
                }),

            SizedBox(height: 30,),
            CustomButton(
              title: "Verify",
              clickButton: () {
                // if (formkey.currentState!.validate()) {
                // FireAuth.signInUsingEmailPassword(email: emailTextController.text, password: passwordTextController.text, context: context);
                // }
                provider.signInWithPhoneNumber(pin,context);
              },
              width: double.infinity,
            ),

          ],  
          ),
          ),
        ),
      );
        }
    )
    );
  }

}