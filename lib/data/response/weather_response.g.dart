// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ParentWeatherResponse _$ParentWeatherResponseFromJson(
    Map<String, dynamic> json) {
  return ParentWeatherResponse(
    weathers: (json['weather'] as List<dynamic>?)
        ?.map((e) => WeatherResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    main: json['main'] == null
        ? null
        : MainResponse.fromJson(json['main'] as Map<String, dynamic>),
    visibility: json['visibility'] as int?,
    wind: json['wind'] == null
        ? null
        : WindResponse.fromJson(json['wind'] as Map<String, dynamic>),
    sys: json['sys'] == null
        ? null
        : SysResponse.fromJson(json['sys'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$ParentWeatherResponseToJson(
        ParentWeatherResponse instance) =>
    <String, dynamic>{
      'weather': instance.weathers,
      'main': instance.main,
      'visibility': instance.visibility,
      'wind': instance.wind,
      'sys': instance.sys,
    };

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) {
  return WeatherResponse(
    id: json['id'] as int?,
    description: json['description'] as String?,
    icon: json['icon'] as String?,
  );
}

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'icon': instance.icon,
    };

WindResponse _$WindResponseFromJson(Map<String, dynamic> json) {
  return WindResponse(
    speed: json['speed'] as num?,
    deg: json['deg'] as num?,
    gust: json['gust'] as num?,
  );
}

Map<String, dynamic> _$WindResponseToJson(WindResponse instance) =>
    <String, dynamic>{
      'speed': instance.speed,
      'deg': instance.deg,
      'gust': instance.gust,
    };

MainResponse _$MainResponseFromJson(Map<String, dynamic> json) {
  return MainResponse(
    temp: json['temp'] as num?,
    tempMin: json['temp_min'] as num?,
    tempMax: json['temp_max'] as num?,
    tempFeel: json['feels_like'] as num?,
    humidity: json['humidity'] as num?,
  );
}

Map<String, dynamic> _$MainResponseToJson(MainResponse instance) =>
    <String, dynamic>{
      'temp': instance.temp,
      'temp_min': instance.tempMin,
      'temp_max': instance.tempMax,
      'feels_like': instance.tempFeel,
      'humidity': instance.humidity,
    };

SysResponse _$SysResponseFromJson(Map<String, dynamic> json) {
  return SysResponse(
    sunrise: json['sunrise'] as num?,
    sunset: json['sunset'] as num?,
  );
}

Map<String, dynamic> _$SysResponseToJson(SysResponse instance) =>
    <String, dynamic>{
      'sunrise': instance.sunrise,
      'sunset': instance.sunset,
    };
