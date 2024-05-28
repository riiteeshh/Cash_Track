// ignore_for_file: non_constant_identifier_names

import 'package:cash_track/utils/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:cash_track/utils/routes/routes.dart';
import 'package:flutter/cupertino.dart';

void SignUpActionStates(BuildContext context, SignUpState state) {
  if (state is NavigateToHomePage) {
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacementNamed(context, RouteManager.mainLayoutPage);
  }
}
