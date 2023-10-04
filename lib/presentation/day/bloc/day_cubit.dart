import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/presentation/day/bloc/day_state.dart';

class DayCubit extends Cubit<DayState> {
  DayCubit() : super(DayInit());
  BehaviorSubject<DateTime> changeDateTimeSubject = BehaviorSubject();



}
