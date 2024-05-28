// ignore_for_file: must_be_immutable

import 'package:cash_track/actions/profile_page_action_state.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:cash_track/widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_initicon/flutter_initicon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileView extends StatelessWidget {
  ProfileView({super.key});
  ProfileBlocBloc profileBlocBloc = BlocInstance.profileBlocBloc;
  final fullName = TextEditingController();
  final address = TextEditingController();
  final jobTitle = TextEditingController();
  final income = TextEditingController();
  final email = TextEditingController();
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
    return BlocConsumer<ProfileBlocBloc, ProfileBlocState>(
      bloc: profileBlocBloc,
      listener: (context, state) {
        profilePageActionState(context, state);
      },
      builder: (context, state) {
        if (state is ProfileBlocLoadedState) {
          fullName.text = state.profileDetails[0]['name'] ?? '';
          address.text = state.profileDetails[0]['address'] ?? '';

          email.text = state.profileDetails[0]['email'] ?? '';

          jobTitle.text = state.profileDetails[0]['jobtitle'] ?? '';

          income.text = state.profileDetails[0]['salary'].toString() ?? '';
          updateDate =
              state.profileDetails[0]['incomeupdateddate'].toString() ?? '';
          _selectedNumber =
              DateTime.parse(state.profileDetails[0]['incomeupdateddate']).day;

          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              actions: [
                (state.readOnly)
                    ? Container(
                        width: MediaQuery.sizeOf(context).width * 0.25,
                        height: MediaQuery.sizeOf(context).height * 0.04,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: OutlinedButton.icon(
                          onPressed: () {
                            profileBlocBloc.add(
                                ToggleReadOnlyEvent(readOnly: !state.readOnly));
                          },
                          icon: const Icon(CupertinoIcons.pen),
                          label: const Text('Edit'),
                          style: OutlinedButton.styleFrom(
                              padding: EdgeInsets.zero),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                          children: [
                            IconButton.outlined(
                                onPressed: () {
                                  profileBlocBloc.add(ProfileUpdateEvent(
                                    id: state.profileDetails[0]['id'],
                                    fullName: fullName.text,
                                    address: address.text,
                                    email: email.text,
                                    jobTitle: jobTitle.text,
                                    salary: income.text,
                                    incomeUpdateDate: updateDate,
                                  ));
                                },
                                icon: const Icon(CupertinoIcons.check_mark)),
                            IconButton.outlined(
                                onPressed: () {
                                  profileBlocBloc.add(ToggleReadOnlyEvent(
                                      readOnly: !state.readOnly));
                                },
                                icon: const Icon(Icons.close))
                          ],
                        ),
                      )
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: ListView(
                children: [
                  Container(
                      alignment: Alignment.topCenter,
                      child: CircleAvatar(
                        radius: 50.r,
                        backgroundColor: const Color(0xff6a58e7),
                        child: Initicon(
                          size: 90,
                          text: fullName.text,
                          backgroundColor: Colors.transparent,
                          style: TextStyle(fontSize: 50.h),
                        ),
                      )),
                  verticalSpace(20),
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
                    controller: fullName,
                    readOnly: state.readOnly,
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
                    readOnly: state.readOnly,
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
                    controller: email,
                    readOnly: state.readOnly,
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
                    controller: jobTitle,
                    readOnly: state.readOnly,
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
                    readOnly: state.readOnly,
                    textInputAction: TextInputAction.done,
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10))),
                    // Value of the currently selected item
                    value: _selectedNumber != null
                        ? _numberStrings[_selectedNumber! - 1]
                        : null,
                    // Hint text when no item is selected

                    hint: const Text('Select a income update date(A.D)'),
                    // List of DropdownMenuItem widgets
                    items: _numberStrings.map((String number) {
                      return DropdownMenuItem(
                        value: number,
                        child: Text(number.toString()),
                      );
                    }).toList(),
                    // What happens when an item is selected
                    onChanged: (state.readOnly)
                        ? null
                        : (String? newValue) {
                            updateDate = DateTime(
                                    DateTime.now().year,
                                    DateTime.now().month,
                                    int.parse(newValue!
                                        .replaceAll(RegExp(r'[^\d]+'), '')))
                                .toString();
                          },
                  ),
                  verticalSpace(15),
                ],
              ),
            ),
          );
        }
        profileBlocBloc.add(ProfileBlocInitialEvent());
        return const CircularProgressIndicator();
      },
    );
  }
}
