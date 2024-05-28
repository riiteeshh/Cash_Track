part of 'profile_bloc_bloc.dart';

sealed class ProfileBlocEvent {}

class ProfileBlocInitialEvent extends ProfileBlocEvent {}

class ProfileUpdateEvent extends ProfileBlocEvent {
  int id;
  String fullName;
  String address;
  String email;
  String jobTitle;
  String salary;
  String incomeUpdateDate;

  ProfileUpdateEvent({
    required this.id,
    required this.fullName,
    required this.address,
    required this.email,
    required this.jobTitle,
    required this.salary,
    required this.incomeUpdateDate,
  });
}

class ToggleReadOnlyEvent extends ProfileBlocEvent {
  bool readOnly;
  ToggleReadOnlyEvent({
    required this.readOnly,
  });
}
