// ignore_for_file: must_be_immutable

import 'package:cash_track/actions/sign_up_action_state.dart';
import 'package:cash_track/utils/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:cash_track/utils/validator/validator.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpView extends StatelessWidget {
  SignUpView({super.key});
  final formKey = GlobalKey<FormState>();
  final fullName = TextEditingController();
  final address = TextEditingController();
  final jobTitle = TextEditingController();
  final income = TextEditingController();
  final email = TextEditingController();
  SignUpBloc signUpBloc = SignUpBloc();

  final List<String> _numberStrings = List<String>.generate(31, (index) {
    int number = index + 1;
    String suffix;

    if (number % 10 == 1 && number != 11) {
      suffix = 'st';
    } else if (number % 10 == 2 && number != 12) {
      suffix = 'nd';
    } else if (number % 10 == 3 && number != 13) {
      suffix = 'rd';
    } else {
      suffix = 'th';
    }

    return '$number$suffix';
  });
  int? _selectedNumber;
  late String updateDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: const Text(
            'Signup',
            style: TextStyle(fontWeight: FontWeight.w600),
          )),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                'Full Name',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateUserName,
                controller: fullName,
                decoration: InputDecoration(
                    hintText: 'John Mayer',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              verticalSpace(10),
              Text(
                'Address',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              TextFormField(
                controller: address,
                validator: validateAddress,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    hintText: 'Kathmandu,Nepal',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              verticalSpace(10),
              Text(
                'E-mail',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              TextFormField(
                validator: validateEmail,
                controller: email,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    hintText: 'johnmayer@abc.com',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              verticalSpace(10),
              Text(
                'Job Title',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              TextFormField(
                validator: validateJobTitle,
                controller: jobTitle,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    hintText: 'Software Engineer',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              verticalSpace(10),
              Text(
                'Income(Per Month)',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              TextFormField(
                controller: income,
                validator: validateIncome,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    helperText: 'You can modify later too',
                    hintText: '50000',
                    contentPadding: const EdgeInsets.all(15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
              verticalSpace(10),
              Text(
                'Income Update Day(Per Month In A.D.)',
                style: TextStyle(
                    fontSize: 14.h,
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    decoration: TextDecoration.none),
              ),
              verticalSpace(10),
              DropdownButtonFormField<String>(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: validateUpdateDate,

                decoration: InputDecoration(
                    helperText: 'You can modify later too',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                // Value of the currently selected item
                value: _selectedNumber != null
                    ? _numberStrings[_selectedNumber! - 1]
                    : null,
                // Hint text when no item is selected

                hint: const Text('Select a income update date(A.D.)'),
                // List of DropdownMenuItem widgets
                items: _numberStrings.map((String number) {
                  return DropdownMenuItem(
                    value: number,
                    child: Text(number.toString()),
                  );
                }).toList(),
                // What happens when an item is selected
                onChanged: (String? newValue) {
                  updateDate = DateTime(
                          DateTime.now().year,
                          DateTime.now().month,
                          int.parse(
                              newValue!.replaceAll(RegExp(r'[^\d]+'), '')))
                      .toString();
                },
              ),
              verticalSpace(10),
              BlocConsumer<SignUpBloc, SignUpState>(
                bloc: signUpBloc,
                listenWhen: (previous, current) => current is SignUpActionState,
                buildWhen: (previous, current) => current is! SignUpActionState,
                listener: (context, state) {
                  SignUpActionStates(context, state);
                },
                builder: (context, state) {
                  if (state is SignUpLoadingState) {
                    return SizedBox(
                        width: double.maxFinite,
                        height: MediaQuery.sizeOf(context).width * 0.12,
                        child: ElevatedButton(
                          onPressed: null,
                          style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff6a58e7),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          child: const CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ));
                  }
                  return SizedBox(
                      width: double.maxFinite,
                      height: MediaQuery.sizeOf(context).width * 0.12,
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            signUpBloc.add(RegisterUserEvent(
                                name: fullName.text,
                                email: email.text,
                                address: address.text,
                                jobTitle: jobTitle.text,
                                income: income.text,
                                incomeUpdateDate: updateDate));
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff6a58e7),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        child: Text(
                          'Signup',
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
