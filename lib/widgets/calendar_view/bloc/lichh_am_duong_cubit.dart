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

class LichAmDuongCubit extends BaseCubit<LichAmDuongState> {
  LichAmDuongCubit() : super(MainStateInitial());

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

  Future<void> getWeather() async {
    final result = await repo.getWeatherByCityName(
        'Hanoi', 'vi', 'metric', ApiConstants.API_KEY);
    result.when(success: (result) {
      weatherSink.add(result);
    }, error: (error) {});
  }

  void listeningStartDataTime(DateTime dateAndTime) {
    startDate = dateAndTime.formatApiDDMMYYYY;
  }

  final list = [
    Divine(
      'Tử vi hằng ngày',
      ImageAssets.icHoro,
    ),
    Divine(
      'Giải sao',
      ImageAssets.icStar,
    ),
    Divine(
      'Giải mộng',
      ImageAssets.icPeople,
    ),
    Divine(
      'Tử vi trọn đời',
      ImageAssets.icCard,
    ),
    Divine(
      'Cung hoàng đạo',
      ImageAssets.icCung,
    ),
  ];
}

extension DateFormatString on DateTime {
  String get formatApiDDMMYYYY {
    return DateFormat('dd-MM-yyyy').format(this);
  }
}
