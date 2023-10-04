// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';

// ignore: library_prefixes
import 'package:flutter/foundation.dart' as Foundation;
import 'package:get/get.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:my_calendar/data/di/flutter_transformer.dart';
import 'package:my_calendar/data/repository_impl/horo/horo_impl.dart';
import 'package:my_calendar/data/repository_impl/weather/weather_repository_impl.dart';
import 'package:my_calendar/data/service/horo_service.dart';
import 'package:my_calendar/data/service/weather_service.dart';
import 'package:my_calendar/domain/repository/horoscope/horoscope_repository.dart';
import 'package:my_calendar/domain/repository/weather_repository/weather_repository.dart';
import 'package:my_calendar/ultis/constants/api_constant.dart';

void configureDependencies() {
  provideDio(baseUrl: ApiConstants.BASE_URL_WEATHER);
  Get.put(
    WeatherClient(
      provideDio(
        baseUrl: ApiConstants.BASE_URL_WEATHER,
      ),
    ),
  );
  Get.put<WeatherRepository>(
    WeatherRepositoryImpl(Get.find()),
  );
  provideDio(baseUrl: ApiConstants.BASE_URL);
  Get.put(
    HoroClient(
      provideDio(
        baseUrl: ApiConstants.BASE_URL,
      ),
    ),
  );
  Get.put<HoroRepository>(
    HoroRepositoryImpl(Get.find()),
  );

}

int _connectTimeOut = 30000;

Dio provideDio({required String baseUrl}) {
  //final appConstants = Get.find<AppConstants>();
  final options = BaseOptions(
    baseUrl: baseUrl,
    receiveTimeout: _connectTimeOut,
    connectTimeout: _connectTimeOut,
    followRedirects: false,
  );
  final dio = Dio(options);
  dio.transformer = FlutterTransformer();
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest:
          (RequestOptions options, RequestInterceptorHandler handler) async {
        options.baseUrl = baseUrl;
        options.headers['Content-Type'] = 'application/json';
        options.headers['Accept'] = 'application/json, text/javascript, */*; q=0.01';
        options.headers['Accept-Encoding'] = 'gzip, deflate, br';
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response); // continue
      },
      onError: (DioError e, handler) => handler.next(e),
    ),
  );
  if (Foundation.kDebugMode) {
    dio.interceptors.add(dioLogger());
  }
  return dio;
}

PrettyDioLogger dioLogger() {
  return PrettyDioLogger(
    requestHeader: true,
    requestBody: true,
    maxWidth: 100,
  );
}
