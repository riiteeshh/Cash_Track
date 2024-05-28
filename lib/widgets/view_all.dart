// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:cash_track/constant/bloc_instance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/bloc/home_bloc/home_bloc_bloc.dart';

class ViewAllView extends StatelessWidget {
  String title;
  List listData;
  ViewAllView({super.key, required this.title, required this.listData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: (listData.isEmpty)
          ? Center(
              child: Image.asset(
                'lib/assets/images/empty.gif',
              ),
            )
          : ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: listData.length,
              itemBuilder: (context, index) {
                return (title == 'Top Spending\'s' &&
                        listData[index]['type'] == 'income')
                    ? Wrap()
                    : Card(
                        elevation: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(
                              colors: [
                                Color(0xff6a58e7),
                                Color(0xff9900FF),
                              ],
                              begin: Alignment(
                                  cos(90 * (pi / 180)), sin(90 * (pi / 180))),
                              end: Alignment.bottomRight,
                            ),
                          ),
                          child: ListTile(
                            style: ListTileStyle.list,
                            leading: SvgPicture.asset(
                                listData[index]['iconData'],
                                width: 30.w,
                                height: 30.h,
                                color: Color(0xffeef9fc)),
                            title: Text(
                              listData[index]['name'],
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xfff9fafb),
                                  fontSize: 13.h),
                            ),
                            subtitle: Text(
                              '${listData[index]['description']}',
                              textAlign: TextAlign.start,
                              maxLines: 1,
                              style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.italic,
                                  color: Color(0xfff9fafb),
                                  fontSize: 13.h),
                            ),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Rs.${listData[index]['amount'].toString()}',
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w600,
                                      fontStyle: FontStyle.italic,
                                      color:
                                          (listData[index]['type'] == 'expense')
                                              ? Colors.red
                                              : Colors.green,
                                      fontSize: 14.h),
                                ),
                                Text(
                                  '${listData[index]['date']}',
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.italic,
                                      color: Color(0xfff9fafb),
                                      fontSize: 12.h),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              }),
    );
  }
}
