part of 'statistics_bloc_bloc.dart';

sealed class StatisticsBlocEvent {}

class StatisticsBlocInitialEvent extends StatisticsBlocEvent {
  int duration;
  StatisticsBlocInitialEvent({
    this.duration = 7,
  });
}

class DeleteSpendingEvent extends StatisticsBlocEvent {
  int id;
  String amount;
  String type;
  String duration;
  DeleteSpendingEvent({
    required this.id,
    required this.amount,
    required this.type,
    required this.duration,
  });
}
