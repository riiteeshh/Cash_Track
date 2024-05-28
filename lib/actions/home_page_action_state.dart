import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/widgets/KSnackbar.dart';
import 'package:flutter/material.dart';

void homePageActionState(BuildContext context, HomeBlocState state) {
  if (state is SuccessState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        KSnackBar(message: state.message, type: 'success', context: context));
  }
  if (state is ErrorState) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        KSnackBar(message: state.message, type: 'error', context: context));
  }
}
