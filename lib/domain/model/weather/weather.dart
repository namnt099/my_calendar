class ParentWeather {
  List<Weather> weathers;
  Main main;
  int visibility;
  Wind wind;
  Sys sys;

  ParentWeather({
    required this.weathers,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.sys,
  });
}

class Weather {
  int id;
  String description;
  String icon;

  Weather({this.id = 0, this.description = '', this.icon = ''});
}

class Wind {
  num speed;
  num deg;
  num gust;

  Wind({this.speed = 0, this.deg = 0, this.gust = 0});
}

class Main {
  num temp;
  num tempMin;
  num tempMax;
  num tempFeel;
  num humidity;

  Main({
    this.temp = 0,
    this.tempMin = 0,
    this.tempMax = 0,
    this.tempFeel = 0,
    this.humidity = 0,
  });
}

class Sys {
  num sunrise;
  num sunset;

  Sys({
    this.sunrise = 0,
    this.sunset = 0,
  });
}
