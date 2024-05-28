import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';

part 'statistics_bloc_event.dart';
part 'statistics_bloc_state.dart';

class StatisticsBlocBloc
    extends Bloc<StatisticsBlocEvent, StatisticsBlocState> {
  StatisticsBlocBloc() : super(StatisticsBlocInitial()) {
    on<StatisticsBlocInitialEvent>(statisticsBlocInitialEvent);
    on<DeleteSpendingEvent>(deleteSpendingEvent);
  }
  List transactionList = [];
  List statsDataList = [];
  FutureOr<void> statisticsBlocInitialEvent(StatisticsBlocInitialEvent event,
      Emitter<StatisticsBlocState> emit) async {
    emit(StatiticsBlocLoadedState(
        transactionList: transactionList,
        statsDataList: statsDataList,
        duration: event.duration.toString()));
    transactionList = await BlocInstance.dbHelper.getAll('transactions');
    String todayDate =
        DateTime.now().toIso8601String().split('T')[0].toString();
    String requiredDate =
        (DateTime.now().subtract(Duration(days: event.duration)))
            .toIso8601String()
            .split('T')[0]
            .toString();
    statsDataList = await BlocInstance.dbHelper
        .rawQueryy('''SELECT date, SUM(amount) AS totalAmount
    FROM transactions
    WHERE type='expense' AND date >= '$requiredDate' 
      AND date <= '$todayDate'
    GROUP BY date''');
    emit(StatiticsBlocLoadedState(
        transactionList: transactionList,
        statsDataList: statsDataList,
        duration: event.duration.toString()));
  }

  FutureOr<void> deleteSpendingEvent(
      DeleteSpendingEvent event, Emitter<StatisticsBlocState> emit) async {
    List details = await BlocInstance.dbHelper.getAll('details');
    await BlocInstance.dbHelper.delete('transactions', event.id);
    if (event.type == 'expense') {
      await BlocInstance.dbHelper.update('details', {
        'id': 1,
        'updatedmoney':
            (details[0]['updatedmoney'] - double.parse(event.amount)),
      });
    } else {
      await BlocInstance.dbHelper.update('details', {
        'id': 1,
        'initialmoney':
            (details[0]['initialmoney'] - double.parse(event.amount)),
      });
    }
    transactionList = await BlocInstance.dbHelper.getAll('transactions');
    String todayDate =
        DateTime.now().toIso8601String().split('T')[0].toString();
    String requiredDate =
        (DateTime.now().subtract(Duration(days: int.parse(event.duration))))
            .toIso8601String()
            .split('T')[0]
            .toString();
    statsDataList = await BlocInstance.dbHelper
        .rawQueryy('''SELECT date, SUM(amount) AS totalAmount
    FROM transactions
    WHERE type='expense' AND date >= '$requiredDate' 
      AND date <= '$todayDate'
    GROUP BY date''');
    emit(SuccessState(
        message: 'Your transaction has been deleted successfully'));
    emit(StatiticsBlocLoadedState(
        transactionList: transactionList,
        statsDataList: statsDataList,
        duration: event.duration));
    BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
  }
}
