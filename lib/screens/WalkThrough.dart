import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strafio/screens/LoginScreen.dart';
import 'package:strafio/utils/AppColors.dart';
import 'package:strafio/utils/NumberStepper.dart';

import '../utils/DotIndicator.dart';
import '../utils/navigation.dart';

class WalkThrough extends StatefulWidget {
  @override
  State<WalkThrough> createState() => WalkThrough1();
}

class WalkThrough1 extends State<WalkThrough>{
  var pos=1;
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);

  bool complete = false;


  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<Widget> list = <Widget>[
      Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Get a full control of your card and spend securely with STRAFIO",textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,),),

            SvgPicture.asset(
              "assets/images/logo/slide1.svg",
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/3,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        children: [
                          TextSpan(
                              text: "Get Started",
                              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white,textBaseline: TextBaseline.alphabetic)),
                          WidgetSpan(
                            child: Icon(Icons.arrow_forward),
                            alignment: PlaceholderAlignment.middle,
                          ),
                        ],
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(40),
                    ),
                    onPressed: () => setState(() {
                      pos = 2;
                      controller.animateToPage(
                        1,
                        duration: _kDuration,
                        curve: _kCurve,
                      );
                    })
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () => navigation.replaceScreen(context, LoginScreen()),
                  child: Text('Skip',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColors.colorPrimary)),
                )
              ],
            )
          ],
        ),
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Create a portfolio of decentralized assets",textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600,),),
          SvgPicture.asset(
            "assets/images/logo/slide2.svg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                            text: "Next",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white,textBaseline: TextBaseline.alphabetic)),
                        WidgetSpan(
                          child: Icon(Icons.arrow_forward),
                          alignment: PlaceholderAlignment.middle,
                        ),
                      ],
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                  onPressed: () => setState(() {
                    pos = 3;
                    controller.animateToPage(
                      2,
                      duration: _kDuration,
                      curve: _kCurve,
                    );
                  })
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: () => navigation.replaceScreen(context, LoginScreen()),
                child: Text('Skip',style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color: AppColors.colorPrimary)),
              )
            ],
          )
          
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Find out about promising projects before others",textAlign: TextAlign.start, style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),),
          SvgPicture.asset(
            "assets/images/logo/slide3.svg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
          ElevatedButton(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "Start",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white,textBaseline: TextBaseline.alphabetic)),
                  ],
                ),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(40),
              ),
              onPressed: () => navigation.replaceScreen(context, LoginScreen())
          )
        ],
      )
    ];

    return Scaffold(
      body: Container(
        child: SafeArea(
          child : Padding( padding: EdgeInsets.all(16),
            child: Stack(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(0, 80, 0, 0),
                  child: PageView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return list[index];
                  },
                ),
                ),
                Positioned(child: NumberStepper(
                  totalSteps: list.length+1,
                  width: MediaQuery.of(context).size.width,
                  curStep: pos,
                  stepCompleteColor: Colors.blue,
                  currentStepColor: Color(0xff000000),
                  inactiveColor: Color(0xff000000),
                  lineWidth: 4,
                ),
                  top: 20,
                )
              ],
            ),
          )

        )
      )
    );

  }

}