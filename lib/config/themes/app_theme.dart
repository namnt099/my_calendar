import 'package:my_calendar/config/app_config.dart';
import 'package:my_calendar/config/resources/color.dart';

class AppTheme {
  static AppColor getInstance() {
    switch (APP_THEME) {
      case AppMode.MAC_DINH:
        return DefaultTheme();
      case AppMode.XANH:
        return BlueTheme();
      case AppMode.HONG:
        return PinkTheme();
      case AppMode.VANG:
        return YellowTheme();
    }
  }
}
