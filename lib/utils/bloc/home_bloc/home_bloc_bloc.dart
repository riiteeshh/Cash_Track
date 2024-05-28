import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBlocBloc extends Bloc<HomeBlocEvent, HomeBlocState> {
  HomeBlocBloc() : super(HomeBlocInitial()) {
    on<HomeBlocInitialEvent>(homeBlocInitial);
    on<DeleteTransactionEvent>(deleteTransactionEvent);
    on<EditTransactionEvent>(editTransactionEvent);
  }
  List detailsList = [];
  List transactionList = [];
  List transactionListOrdered = [];
  FutureOr<void> homeBlocInitial(
      HomeBlocInitialEvent event, Emitter<HomeBlocState> emit) async {
    detailsList = await BlocInstance.dbHelper.getAll('details');

    transactionList = await BlocInstance.dbHelper.getAll('transactions');
    transactionListOrdered = await BlocInstance.dbHelper
        .getAllConditional('transactions', 'amount DESC');

    emit(HomeBlocLoadedState(
        detailsList: detailsList,
        transactionList: transactionList,
        transactionListOrdered: transactionListOrdered));
  }

  FutureOr<void> deleteTransactionEvent(
      DeleteTransactionEvent event, Emitter<HomeBlocState> emit) async {
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
    detailsList = await BlocInstance.dbHelper.getAll('details');
    transactionList = await BlocInstance.dbHelper.getAll('transactions');
    transactionListOrdered = await BlocInstance.dbHelper
        .getAllConditional('transactions', 'amount DESC');
    emit(SuccessState(
        message: 'Your transaction has been deleted successfully'));
    emit(HomeBlocLoadedState(
        detailsList: detailsList,
        transactionList: transactionList,
        transactionListOrdered: transactionListOrdered));
    BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
  }

  FutureOr<void> editTransactionEvent(
      EditTransactionEvent event, Emitter<HomeBlocState> emit) async {
    List details = await BlocInstance.dbHelper.getAll('details');

    DateTime transacrtionDate = await DateTime.parse(event.dateTime);

    Duration difference = await DateTime.now().difference(transacrtionDate);
    await BlocInstance.dbHelper.update('transactions', {
      'id': event.id,
      'description': event.description,
      'amount': num.parse(event.amount)
    });
    if (difference.inDays <= 30) {
      if (event.type == 'income') {
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'initialmoney':
              ((details[0]['initialmoney'] - num.parse(event.initialMoney)) +
                  num.parse(event.amount)),
        });
      } else {
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'updatedmoney':
              ((details[0]['updatedmoney'] - num.parse(event.initialMoney)) +
                  num.parse(event.amount)),
        });
      }
    } else {
      await BlocInstance.dbHelper.update('details', {
        'id': 1,
        'updatedmoney':
            ((details[0]['updatedmoney']) + num.parse(event.amount)),
      });
    }
    emit(SuccessState(
        message: 'Your transaction has been updated successfully.'));
    emit(HomeBlocInitial());
  }
}
