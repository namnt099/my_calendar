// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:my_calendar/data/response/weather_response.dart';
import 'package:my_calendar/ultis/constants/api_constant.dart';
import 'package:retrofit/http.dart';

part 'weather_service.g.dart';

@RestApi()
abstract class WeatherClient {
  @factoryMethod
  factory WeatherClient(Dio dio, {String baseUrl}) = _WeatherClient;

  @POST(ApiConstants.GET_WEATHER)
  Future<ParentWeatherResponse> getWeatherByCityName(
      @Query('q') String? cityName,
      @Query('lang') String? lang,
      @Query('units') String? units,
      @Query('appid') String? api,
      );
}
