import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';

part 'add_transaction_event.dart';
part 'add_transaction_state.dart';

class AddTransactionBloc
    extends Bloc<AddTransactionEvent, AddTransactionState> {
  AddTransactionBloc() : super(AddTransactionInitial()) {
    on<AddTransactionButtonClickedEvent>(addTransactionButtonClickedEvent);
  }

  FutureOr<void> addTransactionButtonClickedEvent(
      AddTransactionButtonClickedEvent event,
      Emitter<AddTransactionState> emit) async {
    emit(AddTransactionLoadingState());
    List details = await BlocInstance.dbHelper.getAll('details');
    if (event.type == 'income' ||
        (details[0]['initialmoney'] >=
            (details[0]['updatedmoney'] + num.parse(event.amount)))) {
      await BlocInstance.dbHelper.insert('transactions', {
        'iconData': event.iconData,
        'name': event.name,
        'description': event.description,
        'type': event.type,
        'amount': num.parse(event.amount),
        'date': DateTime.now().toIso8601String().split('T')[0].toString()
      });

      if (event.type == 'expense') {
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'updatedmoney':
              (details[0]['updatedmoney'] + double.parse(event.amount)),
        });
      } else {
        await BlocInstance.dbHelper.update('details', {
          'id': 1,
          'initialmoney':
              (details[0]['initialmoney'] + double.parse(event.amount)),
        });
      }
      emit(SuccessState(message: 'Your transaction was added successfully.'));
    } else {
      emit(ErrorState(message: 'Sorry.You have not enough balance'));
    }

    BlocInstance.homeBlocBloc.add(HomeBlocInitialEvent());
    BlocInstance.statisticsBlocBloc.add(StatisticsBlocInitialEvent());
    emit(AddTransactionLoadedState());
  }
}
