import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strafio/screens/LoginScreen.dart';
import 'package:strafio/utils/AppColors.dart';

import '../utils/DotIndicator.dart';
import '../utils/navigation.dart';

class WalkThrough extends StatelessWidget{
  var pos=0;
  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  final _kArrowColor = Colors.black.withOpacity(0.8);
  @override
  Widget build(BuildContext context) {
    PageController controller = PageController();
    List<Widget> list = <Widget>[
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/logo/slide1.svg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
          Text("Be successful in Invest",textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,),),
          SizedBox(height: 10,),
          Text("Our platform is designed to help investors around the world dive",textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),
          ElevatedButton(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "  Get Started    ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white, textBaseline: TextBaseline.alphabetic)),
                    WidgetSpan(
                      child: Icon(Icons.arrow_forward),
                      alignment: PlaceholderAlignment.middle,
                    ),
                  ],
                ),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppColors.colorPrimary)
                      )
                  )
              ),
              onPressed: () => controller.animateToPage(
                1,
                duration: _kDuration,
                curve: _kCurve,
              )
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/logo/slide2.svg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
          Text("Find out about promising projects before others",textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("Our platform is designed to help investors around the world dive",textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),
          ElevatedButton(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "  Next   ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white,textBaseline: TextBaseline.alphabetic)),
                    WidgetSpan(
                      child: Icon(Icons.arrow_forward),
                      alignment: PlaceholderAlignment.middle,
                    ),
                  ],
                ),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppColors.colorPrimary)
                      )
                  )
              ),
              onPressed: () => controller.animateToPage(
                2,
                duration: _kDuration,
                curve: _kCurve,
              )
          )
        ],
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(
            "assets/images/logo/slide3.svg",
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height/3,
          ),
          Text("Create a portfolio of decentralized assets",textAlign: TextAlign.center, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text("Our platform is designed to help investors around the world dive",textAlign: TextAlign.center, style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),),
          SizedBox(height: 10,),
          ElevatedButton(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  children: [
                    TextSpan(
                        text: "   Start       ",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14,color: Colors.white,textBaseline: TextBaseline.alphabetic)),
                  ],
                ),
              ),
              style: ButtonStyle(
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.colorPrimary),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: AppColors.colorPrimary)
                      )
                  )
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
                PageView.builder(
                  physics: new AlwaysScrollableScrollPhysics(),
                  controller: controller,
                  itemCount: list.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return list[index];
                  },
                ),
                Positioned(
                  top: 0,
                  width: MediaQuery.of(context).size.width-35,
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DotsIndicator(
                      controller: controller,
                      itemCount: list.length,
                      onPageSelected: (int page) {
                        controller.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                    ElevatedButton(
                        child: Text(
                            "  Skip  ",
                            style: TextStyle(fontSize: 10)
                        ),
                        style: ButtonStyle(
                            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(color: Colors.black)
                                )
                            )
                        ),
                        onPressed: ()  => navigation.replaceScreen(context, LoginScreen())
                    )
                  ],
                ),
                ),

              ],
            ),
          )

        )
      )
    );
  }

}