import 'package:cash_track/utils/bloc/add_transaction_bloc/add_transaction_bloc.dart';
import 'package:cash_track/widgets/KSnackbar.dart';
import 'package:flutter/material.dart';

void addTransactionActionState(
    BuildContext context, AddTransactionState state) {
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
