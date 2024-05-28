import 'package:cash_track/actions/savings_page_action_state.dart';
import 'package:cash_track/utils/bloc/goals_bloc/goals_bloc_bloc.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SavingsView extends StatefulWidget {
  const SavingsView({super.key});

  @override
  State<SavingsView> createState() => _SavingsViewState();
}

class _SavingsViewState extends State<SavingsView> {
  bool isExpenseSelected = true;
  bool isIncomeSelected = false;
  int selectedIndex = 10000;
  String iconData = 'lib/assets/images/12.svg';
  List<String> categoryName = [
    'Bills',
    'Business',
    'Flight',
    'Food',
    'Fuel',
    'Health',
    'Stocks',
    'Others',
    'Rent',
    'Restaurant',
    'Salary',
    'Shopping',
    'Savings'
  ];
  final description = TextEditingController();
  final amount = TextEditingController();

  GoalsBlocBloc goalsBlocBloc = GoalsBlocBloc();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.09),
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10.r),
          color: Colors.white),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height,
                  child: Column(
                    children: [
                      verticalSpace(15),
                      Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          'Add Savings Details',
                          style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 16.h,
                              fontWeight: FontWeight.w600,
                              decoration: TextDecoration.none),
                        ),
                      ),
                      verticalSpace(15),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Name',
                            style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          verticalSpace(10),
                          Material(
                            child: TextFormField(
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              controller: description,
                              decoration: InputDecoration(
                                  hintText: 'Description',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          verticalSpace(10),
                          Text(
                            'Goal',
                            style: TextStyle(
                                fontSize: 14.h,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                          verticalSpace(10),
                          Material(
                            child: TextFormField(
                              textInputAction: TextInputAction.done,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              controller: amount,
                              decoration: InputDecoration(
                                  hintText: 'Goal',
                                  contentPadding: const EdgeInsets.all(15),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10))),
                            ),
                          ),
                          verticalSpace(15),
                          Text(
                            'Choose Icon',
                            style: GoogleFonts.poppins(
                                color: Colors.black,
                                fontSize: 18.h,
                                fontWeight: FontWeight.w400,
                                decoration: TextDecoration.none),
                          ),
                          Material(
                            child: SizedBox(
                              width: double.maxFinite,
                              height: MediaQuery.sizeOf(context).height * 0.35,
                              child: GridView.builder(
                                  padding: EdgeInsets.zero,
                                  itemCount: 13,
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio:
                                              MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.0009),
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedIndex = index;
                                          iconData =
                                              'lib/assets/images/${index.toString()}.svg';
                                        });
                                      },
                                      child: Card(
                                        elevation: 0,
                                        color: Colors.white,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Card(
                                              elevation: 0,
                                              color: (selectedIndex == index)
                                                  ? const Color(0xff6a58e7)
                                                  : Colors.white,
                                              child: SizedBox(
                                                width: 60,
                                                height: 55,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: SvgPicture.asset(
                                                      'lib/assets/images/${index.toString()}.svg',
                                                      color: (selectedIndex ==
                                                              index)
                                                          ? Colors.white
                                                          : const Color(
                                                              0xff6a58e7)),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              categoryName[index],
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              BlocConsumer<GoalsBlocBloc, GoalsBlocState>(
                bloc: goalsBlocBloc,
                listener: (context, state) {
                  goalsPageActionState(context, state);
                },
                builder: (context, state) {
                  if (state is GoalsBlocLoadingState) {
                    SafeArea(
                        child: Container(
                            width: double.maxFinite,
                            height: MediaQuery.sizeOf(context).width * 0.12,
                            child: ElevatedButton(
                              onPressed: null,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xff6a58e7),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              child: const CircularProgressIndicator(),
                            )));
                  }
                  return Container(
                      width: double.maxFinite,
                      height: MediaQuery.sizeOf(context).width * 0.12,
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          goalsBlocBloc.add(GoalsBlocButtonClickedEvent(
                              name: description.text,
                              goal: amount.text,
                              iconData: iconData));
                          description.clear();
                          amount.clear();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6a58e7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Continue',
                          style: TextStyle(
                            fontSize: 18.h,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
