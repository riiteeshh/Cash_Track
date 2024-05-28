part of 'goals_bloc_bloc.dart';

sealed class GoalsBlocEvent {}

class GoalsBlocInitialEvent extends GoalsBlocEvent {}

class GoalsBlocButtonClickedEvent extends GoalsBlocEvent {
  String name;
  String goal;
  String iconData;
  GoalsBlocButtonClickedEvent({
    required this.name,
    required this.goal,
    required this.iconData,
  });
}

class GoalsBlocAddSavings extends GoalsBlocEvent {
  int id;
  String amount;
  GoalsBlocAddSavings({
    required this.id,
    required this.amount,
  });
}

class DeleteSavings extends GoalsBlocEvent {
  int id;
  DeleteSavings({
    required this.id,
  });
}
