part of 'sign_up_bloc.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

class SignUpActionState extends SignUpState {}

class SignUpLoadingState extends SignUpState {}

class NavigateToHomePage extends SignUpActionState {}
