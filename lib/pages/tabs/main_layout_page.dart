import 'package:cash_track/pages/others/bottom_sheet/add_transaction_bottom_sheet.dart';
import 'package:cash_track/pages/others/goals_page/goals_view.dart';
import 'package:cash_track/pages/others/home_page/home_view.dart';
import 'package:cash_track/pages/others/profile_page/profile_view.dart';
import 'package:cash_track/pages/others/statistics_page/statistics_view.dart';
import 'package:cash_track/utils/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int currentIndex = 0;

  List<Widget> pages = [
    HomeView(),
    const StatisticsView(),
    GoalsView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primaryColorLight,
          elevation: 0,
          shape: const CircleBorder(),
          child: Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'lib/assets/images/add_button.svg',
              color: Colors.white,
              //height: 30.h,
            ),
          ),
          onPressed: () {
            showCupertinoModalPopup(
                context: context,
                builder: (context) {
                  return const TransactionAdditionView();
                });
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: BottomNavigationBar(
          useLegacyColorScheme: false,
          enableFeedback: false,
          selectedItemColor: const Color(0xff444ce7),
          unselectedItemColor: const Color(0xff6E6E6E),
          backgroundColor: const Color(0xffffffff),
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (value) {
            setState(() {
              currentIndex = value;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chart_bar), label: 'Statistics'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.heart), label: 'Goals'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person), label: 'Profile'),
          ]),
      body: GestureDetector(
          onTap: () {
            SystemChannels.textInput.invokeMethod('TextInput.hide');
          },
          child: pages[currentIndex]),
    );
  }
}
