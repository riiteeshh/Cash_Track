import 'package:cash_track/utils/bloc/goals_bloc/goals_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/home_bloc/home_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/profile_bloc/profile_bloc_bloc.dart';
import 'package:cash_track/utils/bloc/statistics_bloc/statistics_bloc_bloc.dart';
import 'package:cash_track/utils/helper/db_helper.dart';

class BlocInstance {
  static final HomeBlocBloc homeBlocBloc = HomeBlocBloc();
  static final StatisticsBlocBloc statisticsBlocBloc = StatisticsBlocBloc();
  static final GoalsBlocBloc goalsBlocBloc = GoalsBlocBloc();
  static final ProfileBlocBloc profileBlocBloc = ProfileBlocBloc();
  static final DbHelper dbHelper = DbHelper();
}
