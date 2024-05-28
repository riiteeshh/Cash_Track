part of 'profile_bloc_bloc.dart';

sealed class ProfileBlocState {}

final class ProfileBlocInitial extends ProfileBlocState {}

class ProfileBlocLoadedState extends ProfileBlocState {
  List profileDetails;
  bool readOnly;
  bool isBusy;
  ProfileBlocLoadedState({
    required this.profileDetails,
    this.readOnly = true,
    this.isBusy = false,
  });
}

class ProfileBlocActionState extends ProfileBlocState {}

class SuccessState extends ProfileBlocActionState {
  String message;
  SuccessState({
    required this.message,
  });
}

class ErrorState extends ProfileBlocActionState {
  String message;
  ErrorState({
    required this.message,
  });
}
