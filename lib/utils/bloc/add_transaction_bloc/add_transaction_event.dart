part of 'add_transaction_bloc.dart';

sealed class AddTransactionEvent {}

class AddTransactionButtonClickedEvent extends AddTransactionEvent {
  String name;
  String description;
  String type;
  String amount;
  String iconData;
  AddTransactionButtonClickedEvent({
    required this.name,
    required this.description,
    required this.iconData,
    required this.type,
    required this.amount,
  });
}
