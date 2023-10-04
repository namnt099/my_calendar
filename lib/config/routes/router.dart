import 'package:flutter/material.dart';
import 'package:my_calendar/presentation/book_ticket/ui/book_ticket.dart';
import 'package:my_calendar/presentation/main_screen/ui/main_screen.dart';
import 'package:my_calendar/presentation/splash/ui/splash.dart';

typedef AppWidgetBuilder = Widget Function(BuildContext, RouteSettings);

class AppRouter {
  static const dfNamed = Navigator.defaultRouteName;

  static const splash = '/splash';
  static const main = '/';

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    // final args = settings.arguments;
    switch (settings.name) {
      case main:
        return MaterialPageRoute(
          builder: (ctx) => const MainTabBarView(),
        );
      case splash:
        return MaterialPageRoute(
          builder: (ctx) => const SplashScreen(),
        );
    }
    return null;
  }
}
