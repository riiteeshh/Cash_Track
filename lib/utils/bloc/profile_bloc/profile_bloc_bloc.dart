import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/goals_bloc/goals_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';

part 'profile_bloc_event.dart';
part 'profile_bloc_state.dart';

class ProfileBlocBloc extends Bloc<ProfileBlocEvent, ProfileBlocState> {
  ProfileBlocBloc() : super(ProfileBlocInitial()) {
    on<ProfileBlocInitialEvent>(profileBlocInitialEvent);
    on<ProfileUpdateEvent>(profileUpdateEvent);
    on<ToggleReadOnlyEvent>(toggleReadOnlyEvent);
  }
  List detailsData = [];
  FutureOr<void> profileBlocInitialEvent(
      ProfileBlocInitialEvent event, Emitter<ProfileBlocState> emit) async {
    detailsData = await BlocInstance.dbHelper.getAll('details');
    emit(ProfileBlocLoadedState(profileDetails: detailsData));
  }

  FutureOr<void> profileUpdateEvent(
      ProfileUpdateEvent event, Emitter<ProfileBlocState> emit) async {
    BlocInstance.dbHelper.update('details', {
      'id': event.id,
      'name': event.fullName,
      'address': event.address,
      'email': event.email,
      'jobtitle': event.jobTitle,
      'salary': event.salary,
      'incomeupdateddate': event.incomeUpdateDate,
    });
    emit(SuccessState(message: 'Your details has been updated successfully'));
    BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
    BlocInstance.goalsBlocBloc.add(GoalsBlocInitialEvent());
    BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
    emit(ProfileBlocInitial());
  }

  FutureOr<void> toggleReadOnlyEvent(
      ToggleReadOnlyEvent event, Emitter<ProfileBlocState> emit) async {
    emit(ProfileBlocLoadedState(
        profileDetails: detailsData, readOnly: event.readOnly));
  }
}
