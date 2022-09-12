import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../connectivity/no_internet_screen.dart';
import '../providers/HomeProvider.dart';
import '../utils/AppColors.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();

}

class HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return NoInternetScreen(
        child: ChangeNotifierProvider(
          create: (context) => HomeProvider(),
          child: Consumer<HomeProvider>(builder: (context, provider, _) {
            return Scaffold(
                backgroundColor: AppColors.screencolor,
                body:  SingleChildScrollView(
            physics: PageScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Stack(
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(16),child:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hi, ${provider.username} !',style: TextStyle(fontWeight: FontWeight.w600, fontSize: 26, color: Colors.white),),
                      Icon(Icons.dark_mode_outlined, color: Colors.white,)
                    ],
                  ),
                  ),
                  Padding(padding: EdgeInsets.all(10), child: Text('Start investing on your future!',style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500),)),
                  Padding(padding: EdgeInsets.fromLTRB(0,20,0,0), child: ClipOval(
                    child: CachedNetworkImage(
                      height: 120,
                      width: 120,
                      fit: BoxFit.cover,
                      imageUrl: provider.profileImage,
                      errorWidget: (context, url, error) =>
                      const Icon(Icons.error),
                    ),
                  )
                  )

                ],
              ),
            )
            ]
            ),
            ]
            ),
            ),
            );
          }
          ),
        ));
  }
}