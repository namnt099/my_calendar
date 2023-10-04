import 'package:json_annotation/json_annotation.dart';
import 'package:my_calendar/domain/model/weather/weather.dart';

part 'weather_response.g.dart';

@JsonSerializable()
class ParentWeatherResponse {
  @JsonKey(name: 'weather')
  List<WeatherResponse>? weathers;
  @JsonKey(name: 'main')
  MainResponse? main;
  @JsonKey(name: 'visibility')
  int? visibility;
  @JsonKey(name: 'wind')
  WindResponse? wind;
  @JsonKey(name: 'sys')
  SysResponse? sys;

  ParentWeatherResponse({
    required this.weathers,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.sys,
  });

  factory ParentWeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$ParentWeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ParentWeatherResponseToJson(this);

  ParentWeather toDomain() => ParentWeather(
        weathers: weathers?.map((e) => e.toDomain()).toList() ?? [],
        main: main?.toDomain() ?? Main(),
        visibility: visibility ?? 0,
        wind: wind?.toDomain() ?? Wind(),
        sys: sys?.toDomain() ?? Sys(),
      );
}

@JsonSerializable()
class WeatherResponse {
  @JsonKey(name: 'id')
  int? id;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'icon')
  String? icon;

  WeatherResponse({
    required this.id,
    required this.description,
    required this.icon,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WeatherResponseToJson(this);

  Weather toDomain() => Weather(
        id: id ?? 0,
        description: description ?? '',
        icon: icon ?? '',
      );
}

@JsonSerializable()
class WindResponse {
  @JsonKey(name: 'speed')
  num? speed;
  @JsonKey(name: 'deg')
  num? deg;
  @JsonKey(name: 'gust')
  num? gust;

  WindResponse({required this.speed, required this.deg, required this.gust});

  factory WindResponse.fromJson(Map<String, dynamic> json) =>
      _$WindResponseFromJson(json);

  Map<String, dynamic> toJson() => _$WindResponseToJson(this);

  Wind toDomain() => Wind(
        speed: speed ?? 0,
        deg: deg ?? 0,
        gust: gust ?? 0,
      );
}

@JsonSerializable()
class MainResponse {
  @JsonKey(name: 'temp')
  num? temp;
  @JsonKey(name: 'temp_min')
  num? tempMin;

  @JsonKey(name: 'temp_max')
  num? tempMax;
  @JsonKey(name: 'feels_like')
  num? tempFeel;
  @JsonKey(name: 'humidity')
  num? humidity;

  MainResponse({
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.tempFeel,
    required this.humidity,
  });

  factory MainResponse.fromJson(Map<String, dynamic> json) =>
      _$MainResponseFromJson(json);

  Map<String, dynamic> toJson() => _$MainResponseToJson(this);

  Main toDomain() => Main(
        temp: temp ?? 0,
        tempMin: tempMin ?? 0,
        tempMax: tempMax ?? 0,
        tempFeel: tempFeel ?? 0,
        humidity: humidity ?? 0,
      );
}

@JsonSerializable()
class SysResponse {
  @JsonKey(name: 'sunrise')
  num? sunrise;
  @JsonKey(name: 'sunset')
  num? sunset;

  SysResponse({required this.sunrise, required this.sunset});

  factory SysResponse.fromJson(Map<String, dynamic> json) =>
      _$SysResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SysResponseToJson(this);

  Sys toDomain() => Sys(
        sunrise: sunrise ?? 0,
        sunset: sunset ?? 0,
      );
}
