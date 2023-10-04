import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/base/base_cubit.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/domain/model/devine.dart';
import 'package:my_calendar/domain/model/weather/weather.dart';
import 'package:my_calendar/domain/repository/weather_repository/weather_repository.dart';
import 'package:my_calendar/ultis/constants/api_constant.dart';
import 'package:my_calendar/widgets/calendar_view/bloc/lich_am_duong_state.dart';

class TibeCubit extends BaseCubit<LichAmDuongState> {
  TibeCubit() : super(MainStateInitial());

  String startDate = DateTime.now().formatApiDDMMYYYY;
  DateTime selectTime = DateTime.now();
  BehaviorSubject<DateTime> changeDateTimeSubject = BehaviorSubject();
  BehaviorSubject<DateTime> dateTimeSubject = BehaviorSubject();
  DateTime time = DateTime.now();
  BehaviorSubject<ParentWeather> _weatherSubject = BehaviorSubject();
  Sink<ParentWeather> get weatherSink => _weatherSubject.sink;
  Stream<ParentWeather> get weatherStream => _weatherSubject.stream;
  WeatherRepository get repo => Get.find();

  bool selectDay(DateTime day) {
    return selectTime.year == day.year &&
        selectTime.month == day.month &&
        selectTime.day == day.day;
  }


  void listeningStartDataTime(DateTime dateAndTime) {
    startDate = dateAndTime.formatApiDDMMYYYY;
  }

}

extension DateFormatString on DateTime {
  String get formatApiDDMMYYYY {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
