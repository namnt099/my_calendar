import 'package:my_calendar/domain/model/weather/weather.dart';

import '../../../data/result/result.dart';

mixin WeatherRepository {
  Future<Result<ParentWeather>> getWeatherByCityName(
      String cityName, String lang, String units, String apiKey);
}
