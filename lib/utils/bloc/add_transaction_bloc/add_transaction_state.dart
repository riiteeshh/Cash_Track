part of 'add_transaction_bloc.dart';

sealed class AddTransactionState {}

final class AddTransactionInitial extends AddTransactionState {}

class AddTransactionLoadedState extends AddTransactionState {}

class AddTransactionLoadingState extends AddTransactionState {}

class AddTransactionActionState extends AddTransactionState {}

class SuccessState extends AddTransactionActionState {
  String message;
  SuccessState({
    required this.message,
  });
}

class ErrorState extends AddTransactionActionState {
  String message;
  ErrorState({
    required this.message,
  });
}
