import 'package:my_calendar/data/response/weather_response.dart';
import 'package:my_calendar/data/result/result.dart';
import 'package:my_calendar/data/service/weather_service.dart';
import 'package:my_calendar/domain/model/weather/weather.dart';
import 'package:my_calendar/domain/repository/weather_repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherClient weatherClient;

  WeatherRepositoryImpl(this.weatherClient);

  @override
  Future<Result<ParentWeather>> getWeatherByCityName(
    String cityName,
    String lang,
    String units,
    String apiKey,
  ) {
    return runCatchingAsync<ParentWeatherResponse, ParentWeather>(
      () => weatherClient.getWeatherByCityName(
        cityName,
        lang,
        units,
        apiKey,
      ),
      (res) => res.toDomain(),
    );
  }
}
