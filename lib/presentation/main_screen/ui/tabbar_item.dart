import 'package:flutter/material.dart';
import 'package:my_calendar/config/resources/image_asset.dart';
import 'package:my_calendar/config/themes/app_theme.dart';
import 'package:my_calendar/generated/l10n.dart';
import 'package:my_calendar/presentation/day/ui/day.dart';
import 'package:my_calendar/presentation/explore/explore.dart';
import 'package:my_calendar/presentation/home/ui/home_screen.dart';
import 'package:my_calendar/presentation/horoscrope/ui/horoscope.dart';
import 'package:my_calendar/widgets/webview/ui/web_view_screen.dart';

import '../../tibe/tibe.dart';

enum TabBarType { HOME, CALENDAR, TIBE, HOROSCOPE, EXPLORE }

List<TabBarType> getTabListItem() {
  return [
    TabBarType.HOME,
    TabBarType.CALENDAR,
    TabBarType.TIBE,
    TabBarType.HOROSCOPE,
    TabBarType.EXPLORE,
  ];
}

class TabBarItem {
  Widget icon;
  String text;

  TabBarItem({required this.icon, required this.text});
}

extension GetType on int {
  TabBarType get type {
    switch (this) {
      case 0:
        return TabBarType.HOME;
      case 1:
        return TabBarType.CALENDAR;
      case 2:
        return TabBarType.TIBE;
      case 3:
        return TabBarType.HOROSCOPE;
      case 4:
        return TabBarType.EXPLORE;
      default:
        return TabBarType.HOME;
    }
  }
}

extension TabbarEnum on TabBarType {
  int get indexing {
    switch (this) {
      case TabBarType.HOME:
        return 0;
      case TabBarType.CALENDAR:
        return 1;
      case TabBarType.TIBE:
        return 2;
      case TabBarType.HOROSCOPE:
        return 3;
      case TabBarType.EXPLORE:
        return 4;
      default:
        return 0;
    }
  }

  Widget getScreen() {
    switch (this) {
      case TabBarType.HOME:
        return const HomeScreen();
      case TabBarType.CALENDAR:
        return const DayScreen();
      case TabBarType.HOROSCOPE:
        return const HoroscopeScreen();
      case TabBarType.TIBE:
        return const TibeScreen();
      case TabBarType.EXPLORE:
        return const ExploreScreen();
    }
  }

  TabBarItem getTabBarItem({bool isSelect = false}) {
    switch (this) {
      case TabBarType.HOME:
        return TabBarItem(
          icon: ImageAssets.svgAssets(
            ImageAssets.icHome,
            color: isSelect ? AppTheme.getInstance().primaryColor() : null,
          ),
          text: S.current.home,
        );
      case TabBarType.CALENDAR:
        return TabBarItem(
          icon: ImageAssets.svgAssets(
            ImageAssets.icDate,
            color: isSelect ? AppTheme.getInstance().primaryColor(): null,
          ),
          text: S.current.calendar,
        );

      case TabBarType.TIBE:
        return TabBarItem(
          icon: ImageAssets.svgAssets(
            ImageAssets.icEvent,
            color: isSelect ? AppTheme.getInstance().primaryColor() : null,
          ),
          text: S.current.tibe,
        );
      case TabBarType.HOROSCOPE:
        return TabBarItem(
          icon: ImageAssets.svgAssets(
            ImageAssets.icYin,
            color: isSelect ? AppTheme.getInstance().primaryColor() : null,
          ),
          text: S.current.horoscope,
        );
      case TabBarType.EXPLORE:
        return TabBarItem(
          icon: ImageAssets.svgAssets(
            ImageAssets.icExplore,
            color: isSelect ? AppTheme.getInstance().primaryColor() : null,
          ),
          text: S.current.explore,
        );
    }
  }
}

class TabScreen {
  Widget widget;
  TabBarType type;

  TabScreen({required this.widget, required this.type});
}
