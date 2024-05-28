part of 'statistics_bloc_bloc.dart';

sealed class StatisticsBlocState {}

final class StatisticsBlocInitial extends StatisticsBlocState {}

class StatiticsBlocLoadedState extends StatisticsBlocState {
  List transactionList;
  List statsDataList;
  String duration;
  StatiticsBlocLoadedState({
    required this.transactionList,
    required this.statsDataList,
    required this.duration,
  });
}

class StatisticsBlocActionState extends StatisticsBlocState {}

class SuccessState extends StatisticsBlocActionState {
  String message;
  SuccessState({
    required this.message,
  });
}

class ErrorState extends StatisticsBlocActionState {
  String message;
  ErrorState({
    required this.message,
  });
}
