import 'package:json_annotation/json_annotation.dart';

part 'app_constants.g.dart';

@JsonSerializable()
class AppConstants {
  @JsonKey(name: 'type')
  String type;
  @JsonKey(name: 'base_url')
  String baseUrl;
  @JsonKey(name: 'base_weather_url')
  String baseWeatherURL;

  AppConstants(
    this.type,
    this.baseUrl,
    this.baseWeatherURL,
  );

  factory AppConstants.fromJson(Map<String, dynamic> json) =>
      _$AppConstantsFromJson(json);
}
