import 'dart:math';

import 'package:cash_track/actions/statistics_page_action_state.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';
import 'package:cash_track/utils/helper/chart_helper.dart';
import 'package:cash_track/utils/themes/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StatisticsView extends StatelessWidget {
  const StatisticsView({Key? key});

  @override
  Widget build(BuildContext context) {
    StatisticsBlocBloc statisticsBlocBloc = BlocInstance.statisticsBlocBloc;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Statistics',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<StatisticsBlocBloc, StatisticsBlocState>(
        bloc: statisticsBlocBloc,
        listener: (context, state) {
          statisticalPageActionState(context, state);
        },
        builder: (context, state) {
          if (state is StatiticsBlocLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          statisticsBlocBloc
                              .add(StatisticsBlocInitialEvent(duration: 7));
                        },
                        child: Chip(
                          label: Text(
                            '7 Days',
                            style: TextStyle(
                                color: (state.duration == '7')
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          backgroundColor: (state.duration == '7')
                              ? AppColors.primaryColorLight
                              : Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          statisticsBlocBloc
                              .add(StatisticsBlocInitialEvent(duration: 15));
                        },
                        child: Chip(
                          label: Text(
                            '15 Days',
                            style: TextStyle(
                                color: (state.duration == '15')
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          backgroundColor: (state.duration == '15')
                              ? AppColors.primaryColorLight
                              : Colors.white,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          statisticsBlocBloc
                              .add(StatisticsBlocInitialEvent(duration: 30));
                        },
                        child: Chip(
                          label: Text(
                            '1 Month',
                            style: TextStyle(
                                color: (state.duration == '30')
                                    ? Colors.white
                                    : Colors.black),
                          ),
                          backgroundColor: (state.duration == '30')
                              ? AppColors.primaryColorLight
                              : Colors.white,
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                  Card(
                    child: Container(
                      // height: MediaQuery.of(context).size.height * 0.25,
                      child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                              width: MediaQuery.sizeOf(context).width,
                              height: MediaQuery.sizeOf(context).height * 0.3,
                              child: buildBarChart(state.statsDataList))),
                    ),
                  ),
                  verticalSpace(10),
                  Text(
                    'Spending details',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 18.h),
                  ),
                  verticalSpace(10),
                  Expanded(
                      child: Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height,
                    child: (state.transactionList.isEmpty)
                        ? Image.asset(
                            'lib/assets/images/empty.gif',
                            width: 60,
                            height: 60,
                          )
                        : ListView.builder(
                            itemCount: state.transactionList.length,
                            itemBuilder: (context, index) {
                              return (state.transactionList[index]['type'] ==
                                      'income')
                                  ? const Wrap()
                                  : Card(
                                      elevation: 1,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                            colors: [
                                              Color(0xff6a58e7),
                                              Color(0xff9900FF),
                                            ],
                                            begin: Alignment(
                                                cos(90 * (pi / 180)),
                                                sin(90 * (pi / 180))),
                                            end: Alignment.bottomRight,
                                          ),
                                        ),
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.08,
                                        child: ListTile(
                                          style: ListTileStyle.list,
                                          leading: SvgPicture.asset(
                                              state.transactionList[index]
                                                  ['iconData'],
                                              width: 30.w,
                                              height: 30.h,
                                              color: Color(0xffeef9fc)),
                                          title: Text(
                                            state.transactionList[index]
                                                ['name'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w600,
                                                color: Color(0xfff9fafb),
                                                fontSize: 13.h),
                                          ),
                                          subtitle: Text(
                                            state.transactionList[index]
                                                ['description'],
                                            style: GoogleFonts.poppins(
                                                fontWeight: FontWeight.w400,
                                                fontStyle: FontStyle.italic,
                                                color: Color(0xfff9fafb),
                                                fontSize: 13.h),
                                          ),
                                          trailing: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Rs.${state.transactionList[index]['amount'].toString()}',
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w600,
                                                    fontStyle: FontStyle.italic,
                                                    color: Color(0xfff9fafb),
                                                    fontSize: 14.h),
                                              ),
                                              Text(
                                                '${state.transactionList[index]['date']}',
                                                textAlign: TextAlign.start,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w500,
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
                  )),
                ],
              ),
            );
          }
          statisticsBlocBloc.add(StatisticsBlocInitialEvent());
          return Container();
        },
      ),
    );
  }

  // Method to generate bar groups from money data
}
