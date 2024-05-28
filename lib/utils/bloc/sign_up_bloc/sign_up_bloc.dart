import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cash_track/constant/bloc_instance.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpInitial()) {
    on<RegisterUserEvent>(registerUserEvent);
  }

  FutureOr<void> registerUserEvent(
      RegisterUserEvent event, Emitter<SignUpState> emit) async {
    await BlocInstance.dbHelper.insert('details', {
      'name': event.name,
      'address': event.address,
      'jobtitle': event.jobTitle,
      'salary': num.parse(event.income),
      'initialmoney': num.parse(event.income),
      'incomeupdateddate': event.incomeUpdateDate,
    });
    emit(NavigateToHomePage());
  }
}
