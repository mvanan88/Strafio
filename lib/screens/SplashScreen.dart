
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:strafio/utils/AppColors.dart';

import '../providers/SplashProvider.dart';
import '../utils/BounceAnimator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(create: (context) => SplashProvider(context),
      child: Consumer<SplashProvider>(
        builder: (context,provider,_){
          return Scaffold(
            backgroundColor: AppColors.colorPrimary,
            body: Container(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    BounceAnimator(
                      builder: (_,__){
                        return Center(
                          child: InteractiveViewer(
                            scaleEnabled: false,
                            boundaryMargin: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: SvgPicture.asset(
                              "assets/images/logo/logo.svg",
                            ),
                          ),
                        );
                      },
                    )
                  ],
                )
            ),
          );
        },
      ),
    );
  }


}