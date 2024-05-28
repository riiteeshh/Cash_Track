part of 'goals_bloc_bloc.dart';

sealed class GoalsBlocState {}

final class GoalsBlocInitial extends GoalsBlocState {}

class GoalsBlocLoadingState extends GoalsBlocState {}

class GoalsBlocLoadedState extends GoalsBlocState {
  List goalsList;
  GoalsBlocLoadedState({
    required this.goalsList,
  });
}

class GoalBlocActionState extends GoalsBlocState {}

class SuccessState extends GoalBlocActionState {
  String message;
  SuccessState({
    required this.message,
  });
}

class ErrorState extends GoalBlocActionState {
  String message;
  ErrorState({
    required this.message,
  });
}
