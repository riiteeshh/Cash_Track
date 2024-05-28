part of 'home_bloc_bloc.dart';

sealed class HomeBlocState {}

final class HomeBlocInitial extends HomeBlocState {}

class HomeBlocLoadedState extends HomeBlocState {
  List detailsList;
  List transactionList;
  List transactionListOrdered;
  HomeBlocLoadedState({
    required this.detailsList,
    required this.transactionList,
    required this.transactionListOrdered,
  });
}

class HomeBlocActionState extends HomeBlocState {}

class SuccessState extends HomeBlocActionState {
  String message;
  SuccessState({
    required this.message,
  });
}

class ErrorState extends HomeBlocActionState {
  String message;
  ErrorState({
    required this.message,
  });
}
