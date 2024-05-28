// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:cash_track/auth/sign_up_page/sign_up_view.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/pages/tabs/main_layout_page.dart';
import 'package:cash_track/utils/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String path = join(await getDatabasesPath(), 'expense_tracker.db');
  if (await File(path).exists()) {
    List details = await BlocInstance.dbHelper.getAll('details');
    if (details.isNotEmpty) {
      if (details[0]['incomeupdateddate'] != null &&
          details[0]['incomeupdateddate'] != '') {
        if (DateTime.now().year >
                DateTime.parse(details[0]['incomeupdateddate']).year ||
            DateTime.now().month >
                DateTime.parse(details[0]['incomeupdateddate']).month) {
          if (DateTime.now().day >=
              DateTime.parse(details[0]['incomeupdateddate']).day) {
            BlocInstance.dbHelper.update('details', {
              'id': 1,
              'initialmoney':
                  ((details[0]['initialmoney'] - details[0]['updatedmoney']) +
                      details[0]['salary']),
              'updatedmoney': 0,
              'incomeupdateddate': (DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                      DateTime.parse(details[0]['incomeupdateddate']).day))
                  .toString(),
            });
          }
        }
      }
    }
  }
  runApp(CashApp(
    isdbAvl: await File(path).exists(),
  ));
}

class CashApp extends StatelessWidget {
  bool isdbAvl;
  CashApp({super.key, required this.isdbAvl});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      ensureScreenSize: true,
      useInheritedMediaQuery: true,
      child: MaterialApp(
        themeMode: ThemeMode.light,
        theme: ThemeData(
            useMaterial3: true,
            cardTheme:
                CardTheme(surfaceTintColor: Colors.white, color: Colors.white),
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0)),
        debugShowCheckedModeBanner: false,
        home: isdbAvl ? MainLayoutView() : SignUpView(),
        onGenerateRoute: RouteManager.onGenerateRoute,
      ),
    );
  }
}
