// ignore_for_file: must_be_immutable

import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/goals_bloc/goals_bloc_bloc.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddSavingsView extends StatelessWidget {
  String name;
  int id;
  AddSavingsView({super.key, required this.id, required this.name});
  final amount = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: MediaQuery.sizeOf(context).height * 0.2),
      decoration: BoxDecoration(
          borderRadius: BorderRadiusDirectional.circular(10.r),
          color: Colors.white),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: ListView(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Text(
                  'Add Savings',
                  style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16.h,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.none),
                ),
              ),
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
                  initialValue: name,
                  readOnly: true,
                  decoration: InputDecoration(
                      hintText: 'Description',
                      disabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              verticalSpace(10),
              Text(
                'Amount',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              Material(
                child: TextFormField(
                  autofocus: true,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  controller: amount,
                  decoration: InputDecoration(
                      hintText: 'Amount',
                      contentPadding: EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10))),
                ),
              ),
              verticalSpace(20),
              Container(
                  width: double.maxFinite,
                  height: MediaQuery.sizeOf(context).width * 0.12,
                  child: ElevatedButton(
                    onPressed: () {
                      BlocInstance.goalsBlocBloc.add(
                          GoalsBlocAddSavings(id: id, amount: amount.text));
                    },
                    child: Text(
                      'Add Money',
                      style: TextStyle(
                        fontSize: 18.h,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff6a58e7),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
