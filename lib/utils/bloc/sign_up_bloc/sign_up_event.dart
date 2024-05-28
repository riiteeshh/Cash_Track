part of 'sign_up_bloc.dart';

sealed class SignUpEvent {}

class RegisterUserEvent extends SignUpEvent {
  String name;
  String address;
  String jobTitle;
  String email;
  String income;
  String incomeUpdateDate;
  RegisterUserEvent({
    required this.name,
    required this.address,
    required this.email,
    required this.jobTitle,
    required this.income,
    required this.incomeUpdateDate,
  });
}
