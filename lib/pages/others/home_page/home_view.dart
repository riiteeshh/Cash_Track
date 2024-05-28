// ignore_for_file: must_be_immutable

import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cash_track/actions/home_page_action_state.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:cash_track/widgets/view_all.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  HomeBlocBloc homeBlocBloc = BlocInstance.homeBlocBloc;
  final description = TextEditingController();
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBlocBloc, HomeBlocState>(
      bloc: homeBlocBloc,
      listener: (context, state) {
        homePageActionState(context, state);
      },
      builder: (context, state) {
        if (state is HomeBlocLoadedState) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: false,
              leading: IconButton.filledTonal(
                  onPressed: () {},
                  style:
                      IconButton.styleFrom(backgroundColor: Color(0xff6a58e7)),
                  icon: Initicon(
                    backgroundColor: Colors.transparent,
                    text: state.detailsList[0]['name'],
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600, fontSize: 15.h),
                    size: 25.h,
                  )),
              titleSpacing: 0,
              title: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Hello, ${state.detailsList[0]['name']}',
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 23.h),
                  ),
                  Text(
                    (DateTime.now().hour >= 12)
                        ? (DateTime.now().hour >= 18 &&
                                DateTime.now().hour < 24)
                            ? 'Good Night'
                            : 'Good Afternoon'
                        : 'Good Morning',
                    style: GoogleFonts.poppins(
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                        fontSize: 12.h),
                  )
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
                  verticalSpace(10),
                  Card(
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
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.28,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            verticalSpace(10),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Total Balance',
                                style: GoogleFonts.poppins(
                                    color: Color(0xfffafafa),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 18.h),
                              ),
                            ),
                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Rs.${(state.detailsList[0]['initialmoney'] - state.detailsList[0]['updatedmoney']).toString()}',
                                style: GoogleFonts.poppins(
                                    color: Color(0xfffafafa),
                                    fontWeight: FontWeight.w400,
                                    fontSize: 16.h),
                              ),
                            ),
                            verticalSpace(5),
                            Text(
                              'Monthly Expenses',
                              style: GoogleFonts.poppins(
                                  color: Color(0xfffafafa),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14.h),
                            ),
                            verticalSpace(5),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                  overlayShape: SliderComponentShape.noOverlay,
                                  trackHeight: 10.h,
                                  thumbColor: Colors.transparent,
                                  thumbShape: const RoundSliderThumbShape(
                                      enabledThumbRadius: 0.0)),
                              child: Slider(
                                  activeColor: Colors.red,
                                  inactiveColor: Color(0xffd3d8db),
                                  allowedInteraction: SliderInteraction.tapOnly,
                                  min: 0,
                                  max: state.detailsList[0]['initialmoney'],
                                  value: state.detailsList[0]['updatedmoney'],
                                  onChanged: (value) {}),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Rs.${state.detailsList[0]['updatedmoney'].toString()}',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xfffafafa),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.h),
                                ),
                                Text(
                                  'Rs.${state.detailsList[0]['initialmoney'].toString()}',
                                  style: GoogleFonts.poppins(
                                      color: Color(0xfffafafa),
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14.h),
                                ),
                              ],
                            ),
                            verticalSpace(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Card(
                                  color: Color(0xffd3d8d8),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    // width: MediaQuery.sizeOf(context).width *
                                    //     0.35,
                                    //height: 70.h,
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20.r,
                                          child: Icon(
                                            Icons.arrow_upward,
                                            color: Colors.greenAccent,
                                            size: 20.h,
                                          ),
                                        ),
                                        horizontalSpace(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Income',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.h),
                                            ),
                                            SizedBox(
                                              width: 70.w,
                                              child: AutoSizeText(
                                                'Rs.${state.detailsList[0]['initialmoney'].toString()}',
                                                textAlign: TextAlign.center,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 13.h),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Card(
                                  color: Color(0xffd3d8d8),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    color: Colors.transparent,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        CircleAvatar(
                                          backgroundColor: Colors.white,
                                          radius: 20.r,
                                          child: Icon(
                                            Icons.arrow_downward,
                                            color: Colors.redAccent,
                                            size: 20.h,
                                          ),
                                        ),
                                        horizontalSpace(10),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'Expense',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12.h),
                                            ),
                                            SizedBox(
                                              width: 80.w,
                                              child: AutoSizeText(
                                                'Rs.${state.detailsList[0]['updatedmoney'].toString()}',
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: GoogleFonts.poppins(
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: 14.h),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Top Spending\'s',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 18.h),
                      ),
                      IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllView(
                                        title: 'Top Spending\'s',
                                        listData:
                                            state.transactionListOrdered)));
                          },
                          icon: Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xff68baa6),
                          ))
                    ],
                  ),
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.12,
                    child: (state.transactionList.isEmpty)
                        ? Image.asset(
                            'lib/assets/images/empty.gif',
                          )
                        : ListView.builder(
                            itemCount:
                                (state.transactionListOrdered.length > 10)
                                    ? 10
                                    : state.transactionListOrdered.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, spendingIndex) {
                              return (state.transactionListOrdered[
                                          spendingIndex]['type'] ==
                                      'income')
                                  ? Wrap()
                                  : Row(
                                      children: [
                                        Card(
                                          elevation: 0,
                                          child: Container(
                                            width: 85.w,
                                            height: 90.h,
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
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SvgPicture.asset(
                                                    state.transactionListOrdered[
                                                            spendingIndex]
                                                        ['iconData'],
                                                    width: 30.w,
                                                    height: 30.h,
                                                    color: Color(0xffeef9fc)),
                                                verticalSpace(10),
                                                Text(
                                                  state.transactionListOrdered[
                                                      spendingIndex]['name'],
                                                  maxLines: 2,
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color: Color(0xfff9fafb),
                                                      fontSize: 13.h),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        horizontalSpace(10),
                                      ],
                                    );
                            }),
                  ),
                  verticalSpace(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent Transaction',
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500, fontSize: 18.h),
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ViewAllView(
                                        title: 'Recent Transaction',
                                        listData: state.transactionList)));
                          },
                          child: Text(
                            'View all',
                            style: TextStyle(
                                color: Color(0xff68baa6), fontSize: 14.h),
                          ))
                    ],
                  ),
                  Expanded(
                      child: SizedBox(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height,
                    child: (state.transactionList.isEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Image.asset(
                              'lib/assets/images/empty.gif',
                              width: 20,
                              height: 20,
                            ),
                          )
                        : ListView.builder(
                            padding: EdgeInsets.zero,
                            itemCount: state.transactionList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                // surfaceTintColor: Color(0xffeef9fc),
                                // shadowColor: Color(0xffeef9fc),
                                // color: Color(0xffeef9fc),
                                elevation: 1,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xff6a58e7),
                                        Color(0xff9900FF),
                                      ],
                                      begin: Alignment(cos(90 * (pi / 180)),
                                          sin(90 * (pi / 180))),
                                      end: Alignment.bottomRight,
                                    ),
                                  ),
                                  height:
                                      MediaQuery.sizeOf(context).height * 0.08,
                                  child: ListTile(
                                      style: ListTileStyle.list,
                                      leading: SvgPicture.asset(
                                          state.transactionList[index]
                                              ['iconData'],
                                          width: 30.w,
                                          height: 30.h,
                                          color: Color(0xffeef9fc)),
                                      title: Text(
                                        state.transactionList[index]['name'],
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
                                      contentPadding:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      trailing: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Column(
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
                                                    color:
                                                        (state.transactionList[
                                                                        index]
                                                                    ['type'] ==
                                                                'expense')
                                                            ? Colors.red
                                                            : Colors.green,
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
                                          horizontalSpace(10),
                                          IconButton(
                                            onPressed: () {
                                              description.text = state
                                                  .transactionList[index]
                                                      ['description']
                                                  .toString();
                                              amount.text = state
                                                  .transactionList[index]
                                                      ['amount']
                                                  .toString();
                                              showDialog(
                                                  context: context,
                                                  builder: (context) {
                                                    return Scaffold(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      body: AlertDialog(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10)),
                                                        backgroundColor:
                                                            Colors.white,
                                                        surfaceTintColor:
                                                            Colors.white,
                                                        title: Text(
                                                          'Edit Transaction',
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize:
                                                                      18.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600),
                                                        ),
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              'Description',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                            verticalSpace(10),
                                                            TextFormField(
                                                              autofocus: true,
                                                              controller:
                                                                  description,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .next,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                      disabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            const BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                            ),
                                                            verticalSpace(10),
                                                            Text(
                                                              'Amount',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      13.h,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  color: Colors
                                                                      .black,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .none),
                                                            ),
                                                            verticalSpace(10),
                                                            TextFormField(
                                                              onFieldSubmitted:
                                                                  (value) {
                                                                homeBlocBloc.add(EditTransactionEvent(
                                                                    id: state.transactionList[index]
                                                                        ['id'],
                                                                    description:
                                                                        description
                                                                            .text,
                                                                    dateTime: state
                                                                            .transactionList[index][
                                                                        'date'],
                                                                    amount: amount
                                                                        .text,
                                                                    initialMoney: state
                                                                        .transactionList[index]
                                                                            [
                                                                            'amount']
                                                                        .toString(),
                                                                    type: state
                                                                            .transactionList[index]
                                                                        ['type']));
                                                              },
                                                              controller:
                                                                  amount,
                                                              textInputAction:
                                                                  TextInputAction
                                                                      .go,
                                                              keyboardType:
                                                                  TextInputType
                                                                      .text,
                                                              decoration:
                                                                  InputDecoration(
                                                                      hintText:
                                                                          'Amount',
                                                                      disabledBorder:
                                                                          OutlineInputBorder(
                                                                        borderSide:
                                                                            const BorderSide(color: Colors.white),
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      contentPadding:
                                                                          EdgeInsets.all(
                                                                              15),
                                                                      border: OutlineInputBorder(
                                                                          borderRadius:
                                                                              BorderRadius.circular(10))),
                                                            ),
                                                          ],
                                                        ),
                                                        actions: [
                                                          TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .red),
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                  'Cancel')),
                                                          TextButton(
                                                              style: TextButton
                                                                  .styleFrom(
                                                                      foregroundColor:
                                                                          Colors
                                                                              .green),
                                                              onPressed: () {
                                                                homeBlocBloc.add(EditTransactionEvent(
                                                                    id: state.transactionList[index]
                                                                        ['id'],
                                                                    description:
                                                                        description
                                                                            .text,
                                                                    dateTime: state
                                                                            .transactionList[index][
                                                                        'date'],
                                                                    amount: amount
                                                                        .text,
                                                                    initialMoney: state
                                                                        .transactionList[index]
                                                                            [
                                                                            'amount']
                                                                        .toString(),
                                                                    type: state
                                                                            .transactionList[index]
                                                                        ['type']));
                                                              },
                                                              child:
                                                                  Text('Done')),
                                                        ],
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon: Icon(
                                              CupertinoIcons.pencil,
                                              size: 30.h,
                                            ),
                                            style: IconButton.styleFrom(
                                              foregroundColor: Colors.white,
                                              alignment: Alignment.centerRight,
                                              padding: EdgeInsets.zero,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              );
                            }),
                  )),
                ],
              ),
            ),
          );
        }
        homeBlocBloc.add(HomeBlocInitialEvent());
        return Center(
          child: CircularProgressIndicator(
            color: Colors.red,
          ),
        );
      },
    );
  }
}
