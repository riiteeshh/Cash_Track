import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';

part 'goals_bloc_event.dart';
part 'goals_bloc_state.dart';

class GoalsBlocBloc extends Bloc<GoalsBlocEvent, GoalsBlocState> {
  GoalsBlocBloc() : super(GoalsBlocInitial()) {
    on<GoalsBlocInitialEvent>(goalsBlocInitialEvent);
    on<GoalsBlocButtonClickedEvent>(goalsBlocButtonClickedEvent);
    on<GoalsBlocAddSavings>(goalsBlocAddSavings);
    on<DeleteSavings>(deleteSavings);
  }

  List savingsList = [];
  FutureOr<void> goalsBlocInitialEvent(
      GoalsBlocInitialEvent event, Emitter<GoalsBlocState> emit) async {
    savingsList = await BlocInstance.dbHelper.getAll('savings');
    emit(GoalsBlocLoadedState(goalsList: savingsList));
  }

  FutureOr<void> goalsBlocButtonClickedEvent(
      GoalsBlocButtonClickedEvent event, Emitter<GoalsBlocState> emit) async {
    emit(GoalsBlocLoadingState());
    await BlocInstance.dbHelper.insert('savings', {
      'iconData': event.iconData,
      'name': event.name,
      'goal': num.parse(event.goal),
      'current': 0.0,
      'date': DateTime.now().toIso8601String().split('T')[0].toString()
    });
    emit(SuccessState(message: 'Your goal has been added successfully'));

    BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
    BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
    BlocInstance.goalsBlocBloc.add(GoalsBlocInitialEvent());
  }

  FutureOr<void> goalsBlocAddSavings(
      GoalsBlocAddSavings event, Emitter<GoalsBlocState> emit) async {
    List details = await BlocInstance.dbHelper.getAll('details');
    if ((details[0]['initialmoney'] >=
        (details[0]['updatedmoney'] + num.parse(event.amount)))) {
      List savings = await BlocInstance.dbHelper.getAll('savings');
      int ind = savings.indexWhere((element) => element["id"] == event.id);
      if ((savings[ind]['current'] + num.parse(event.amount)) <=
          savings[ind]['goal']) {
        await BlocInstance.dbHelper.update('savings', {
          'id': event.id,
          'current': (savings[ind]['current'] + double.parse(event.amount)),
        });
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'updatedmoney':
              (details[0]['updatedmoney'] + double.parse(event.amount)),
        });

        emit(SuccessState(message: 'Your savings is added successfully'));
        BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
        BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
        emit(GoalsBlocInitial());
      } else {
        emit(ErrorState(message: 'Sorry. Your total exceeds your goal'));
      }
    } else {
      emit(ErrorState(message: 'Sorry.You have not enough balance'));
    }
  }

  FutureOr<void> deleteSavings(
      DeleteSavings event, Emitter<GoalsBlocState> emit) async {
    List details = await BlocInstance.dbHelper.getAll('details');
    List savings = await BlocInstance.dbHelper.getAll('savings');
    int ind = savings.indexWhere((element) => element["id"] == event.id);

    if (savings[ind]['current'] < savings[ind]['goal']) {
      if (DateTime.parse(savings[ind]['date']).year != DateTime.now().year) {
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'initialmoney':
              (details[0]['initialmoney'] + savings[ind]['current']),
        });
      } else {
        if (DateTime.parse(savings[ind]['date']).month !=
                DateTime.now().month &&
            DateTime.now().day >=
                DateTime.parse(details[0]['incomeupdateddate']).day) {
          await BlocInstance.dbHelper.update('details', {
            'id': 1,
            'initialmoney':
                (details[0]['initialmoney'] + savings[ind]['current']),
          });
        } else {
          await BlocInstance.dbHelper.update('details', {
            'id': 1,
            'updatedmoney':
                (details[0]['updatedmoney'] - savings[ind]['current']),
          });
        }
      }
    } else {}
    await BlocInstance.dbHelper.delete('savings', event.id);
    emit(SuccessState(message: 'Your goal has been removed successfully'));
    BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
    BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
    emit(GoalsBlocInitial());
  }
}
