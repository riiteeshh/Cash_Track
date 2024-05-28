part of 'home_bloc_bloc.dart';

sealed class HomeBlocEvent {}

class HomeBlocInitialEvent extends HomeBlocEvent {}

class DeleteTransactionEvent extends HomeBlocEvent {
  int id;
  String amount;
  String type;
  DeleteTransactionEvent({
    required this.id,
    required this.amount,
    required this.type,
  });
}

class EditTransactionEvent extends HomeBlocEvent {
  int id;
  String description;
  String dateTime;
  String amount;
  String initialMoney;
  String type;
  EditTransactionEvent({
    required this.id,
    required this.description,
    required this.dateTime,
    required this.amount,
    required this.initialMoney,
    required this.type,
  });
}
