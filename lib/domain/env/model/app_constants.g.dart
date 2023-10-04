// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_constants.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppConstants _$AppConstantsFromJson(Map<String, dynamic> json) {
  return AppConstants(
    json['type'] as String,
    json['base_url'] as String,
    json['base_weather_url'] as String,
  );
}

Map<String, dynamic> _$AppConstantsToJson(AppConstants instance) =>
    <String, dynamic>{
      'type': instance.type,
      'base_url': instance.baseUrl,
      'base_weather_url': instance.baseWeatherURL,
    };
