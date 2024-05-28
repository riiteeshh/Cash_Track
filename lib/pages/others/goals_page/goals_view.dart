import 'dart:math';

import 'package:cash_track/actions/savings_page_action_state.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/pages/others/bottom_sheet/add_savings.dart';
import 'package:cash_track/pages/others/bottom_sheet/savings_bottom_sheet.dart';
import 'package:cash_track/utils/bloc/goals_bloc/goals_bloc_bloc.dart';
import 'package:cash_track/utils/themes/colors.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class GoalsView extends StatelessWidget {
  GoalsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Goals',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          BlocConsumer<GoalsBlocBloc, GoalsBlocState>(
            bloc: BlocInstance.goalsBlocBloc,
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              if (state is GoalsBlocLoadedState) {
                return (state.goalsList.isEmpty)
                    ? Wrap()
                    : IconButton.outlined(
                        onPressed: () {
                          showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return SavingsView();
                              });
                        },
                        icon: Icon(
                          CupertinoIcons.add_circled,
                          color: AppColors.primaryColorLight,
                        ));
              }
              return Wrap();
            },
          )
        ],
      ),
      body: BlocConsumer<GoalsBlocBloc, GoalsBlocState>(
        bloc: BlocInstance.goalsBlocBloc,
        listener: (context, state) {
          goalsPageActionState(context, state);
        },
        builder: (context, state) {
          if (state is GoalsBlocLoadedState) {
            return (state.goalsList.isEmpty)
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      verticalSpace(40),
                      Image.asset('lib/assets/images/goals.gif'),
                      verticalSpace(20),
                      Align(
                        alignment: Alignment.center,
                        child: OutlinedButton.icon(
                            onPressed: () {
                              showCupertinoModalPopup(
                                  context: context,
                                  builder: (context) {
                                    return SavingsView();
                                  });
                            },
                            icon: Icon(CupertinoIcons.add_circled),
                            label: Text('Add a new Goal')),
                      ),
                    ],
                  )
                : ListView.builder(
                    itemCount: state.goalsList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Dismissible(
                            background: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red,
                              ),
                              alignment: Alignment.centerRight,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              width: double.maxFinite,
                              child: const Icon(
                                CupertinoIcons.delete,
                                color: Colors.white,
                              ),
                            ),
                            key: UniqueKey(),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) {
                              BlocInstance.goalsBlocBloc.add(DeleteSavings(
                                  id: state.goalsList[index]['id']));
                            },
                            child: Card(
                              // color: Color(0xff6a58e7),
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
                                width: double.infinity,
                                height: MediaQuery.sizeOf(context).height * 0.3,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      verticalSpace(20),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              CircleAvatar(
                                                radius: 30.r,
                                                child: SvgPicture.asset(
                                                    state.goalsList[index]
                                                        ['iconData']),
                                              ),
                                              verticalSpace(5),
                                              Text(
                                                '${state.goalsList[index]['name']}',
                                                style: GoogleFonts.poppins(
                                                    color: Color(0xfffafafa),
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 16.h),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Saved',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14.h,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              verticalSpace(5),
                                              Text(
                                                'Rs.${state.goalsList[index]['current']}',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16.h,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text(
                                                'Goal',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 14.h,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              verticalSpace(5),
                                              Text(
                                                'Rs.${state.goalsList[index]['goal']}',
                                                style: GoogleFonts.poppins(
                                                    color: Colors.white,
                                                    fontSize: 16.h,
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                      verticalSpace(30),
                                      SliderTheme(
                                        data: SliderTheme.of(context).copyWith(
                                            overlayShape:
                                                SliderComponentShape.noOverlay,
                                            trackHeight: 10,
                                            thumbColor: Colors.transparent,
                                            thumbShape:
                                                const RoundSliderThumbShape(
                                                    enabledThumbRadius: 0.0)),
                                        child: Slider(
                                            activeColor: Color(0xffFF6D3F),
                                            inactiveColor: Color(0xffd3d8db),
                                            allowedInteraction:
                                                SliderInteraction.tapOnly,
                                            min: 0,
                                            max: state.goalsList[index]['goal'],
                                            value: state.goalsList[index]
                                                ['current'],
                                            onChanged: (value) {}),
                                      ),
                                      verticalSpace(10),
                                      Align(
                                        alignment: Alignment.topCenter,
                                        child: OutlinedButton.icon(
                                            onPressed: () {
                                              showCupertinoModalPopup(
                                                  context: context,
                                                  builder: (context) {
                                                    return AddSavingsView(
                                                        id: state.goalsList[
                                                            index]['id'],
                                                        name: state.goalsList[
                                                            index]['name']);
                                                  });
                                            },
                                            style: OutlinedButton.styleFrom(
                                                backgroundColor: Colors.white),
                                            icon: Icon(
                                                CupertinoIcons.add_circled),
                                            label: Text('Add Money')),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          verticalSpace(10),
                        ],
                      );
                    });
          }
          BlocInstance.goalsBlocBloc.add(GoalsBlocInitialEvent());
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
