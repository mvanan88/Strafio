import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/AppColors.dart';
import 'Home.dart';
import 'Tab2.dart';
import 'Tab3.dart';
import 'Tab4.dart';
import 'Tab5.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<HomeScreen> createState() => HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  var selectedIndex = 0;
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: AppColors.tabSelected,
        unselectedItemColor: AppColors.tabUnSelected,
        currentIndex: selectedIndex,
        items: [
          BottomNavigationBarItem(
              icon: selectedIndex == 0
                  ? SvgPicture.asset('assets/images/bottombar/home_selected.svg',
                  height: 35)
                  : SvgPicture.asset('assets/images/bottombar/home.svg',
                  height: 25),
          label: 'Tab 1'),
          BottomNavigationBarItem(
              icon: selectedIndex == 1
                  ? SvgPicture.asset(
                'assets/images/bottombar/tab2_selected.svg',
                height: 35,
              )
                  : SvgPicture.asset(
                'assets/images/bottombar/tab2.svg',
                height: 25,
              ),
              label: 'Tab 2'
          ),
          BottomNavigationBarItem(
              icon: selectedIndex == 2
                  ? SvgPicture.asset(
                'assets/images/bottombar/tab3_selected.svg',
                height: 35,
              )
                  : SvgPicture.asset(
                'assets/images/bottombar/tab3.svg',
                height: 25,
              ),
              label: 'Tab 3'
          ),
          BottomNavigationBarItem(
              icon: selectedIndex == 3
                  ? SvgPicture.asset(
                'assets/images/bottombar/tab4_selected.svg',
                height: 35,
              )
                  : SvgPicture.asset(
                'assets/images/bottombar/tab4.svg',
                height: 25,
              ),
              label: 'Tab 4'
          ),
          BottomNavigationBarItem(
              icon: selectedIndex == 4
                  ? SvgPicture.asset(
                'assets/images/bottombar/tab5_selected.svg',
                height: 35,
              )
                  : SvgPicture.asset(
                'assets/images/bottombar/tab5.svg',
                height: 25,
              ),
              label: 'Tab 5'
          ),
        ],
        onTap: _onTappedBar,
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: pageController,
          onPageChanged: (index) {
            selectedIndex = index;
          },
          children: [
            Home(),
            Tab2(),
            Tab3(),
            Tab4(),
            Tab5()
          ],
        ),
      ),
    );
  }

  void _onTappedBar(int value) {
    setState(() {
      selectedIndex = value;
    });
    pageController.jumpToPage(value);
  }
}