import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:my_calendar/config/app_config.dart';
import 'package:my_calendar/domain/locals/prefs_service.dart';
import 'package:my_calendar/domain/model/theme/app_theme_model.dart';
import 'package:my_calendar/ultis/constants/app_constant.dart';

class AppState {
  void setAppMode(AppMode appMode) {
    APP_THEME = appMode;
    PrefsService.setAppTheme(
      AppThemModel(appMode: APP_THEME, appBackground: APP_BACKGROUND),
    );
    Get.forceAppUpdate();
  }

  void setAppBackGround(AppBackground appBackGround) {
    if (appBackGround == APP_BACKGROUND) {
      APP_BACKGROUND = null;
    } else {
      APP_BACKGROUND = appBackGround;
    }
    PrefsService.setAppTheme(
      AppThemModel(appMode: APP_THEME, appBackground: APP_BACKGROUND),
    );
    Get.forceAppUpdate();
  }

  void getThemeApp() {
    final appTheme = PrefsService.getAppTheme();
    APP_THEME = appTheme.appMode ?? AppMode.MAC_DINH;
    APP_BACKGROUND = appTheme.appBackground;
  }
}
class AppStateProvider extends InheritedWidget {
  final AppState appState;

  const AppStateProvider({
    Key? key,
    required this.appState,
    required Widget child,
  }) : super(key: key, child: child);

  static AppStateProvider of(BuildContext context) {
    final AppStateProvider? result =
    context.dependOnInheritedWidgetOfExactType<AppStateProvider>();
    assert(result != null, 'No element');
    return result!;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return true;
  }
}
