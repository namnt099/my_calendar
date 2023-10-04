import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_calendar/config/base/base_screen.dart';
import 'package:my_calendar/presentation/main_screen/bloc/main_cubit.dart';
import 'package:my_calendar/presentation/main_screen/ui/tabbar_item.dart';
import 'package:my_calendar/presentation/main_screen/ui/widgets/custom_navigator_tabbar.dart';
import 'package:my_calendar/widgets/message_dialog/message_config.dart';

class MainTabBarView extends BaseScreen {
  const MainTabBarView({Key? key, this.tabBarType}) : super(key: key);
  final TabBarType? tabBarType;

  @override
  _MainTabBarViewState createState() => _MainTabBarViewState();
}

class _MainTabBarViewState extends BaseState<MainTabBarView> {
  final List<TabScreen> _listScreen = [];
  final MainCubit _mainCubit = MainCubit();
  late final int random;

  @override
  void initState() {
    super.initState();

    _addScreen(widget.tabBarType ?? TabBarType.HOME);
    _mainCubit.selectTabBarSubject.sink
        .add(widget.tabBarType ?? TabBarType.HOME);
  }

  @override
  void dispose() {
    super.dispose();
    _mainCubit.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<TabBarType>(
      stream: _mainCubit.selectTabBarStream,
      builder: (context, snapshot) {
        final type = snapshot.data ?? TabBarType.HOME;
        return NotificationListener<MyNotification>(
          onNotification: (notification) {
            _addScreen(notification.typeTabBar);
            _mainCubit.selectTab(notification.typeTabBar);
            return true;
          },
          child: Scaffold(
            resizeToAvoidBottomInset: true,
            body: IndexedStack(
              index: _getIndexListScreen(type),
              children: _listScreen.map((e) => e.widget).toList(),
            ),
            bottomNavigationBar: BottomTabBarWidget(
              selectItemIndex: type.indexing,
              onChange: (value) {
                _addScreen(value);
                _mainCubit.selectTab(value);
              }, onDoubleTap: (value ) {  },
            ),
          ),
        );
      },
    );
  }

  int _getIndexListScreen(TabBarType type) {
    return _listScreen
        .indexWhere((element) => element.type.index == type.index);
  }

  void _addScreen(TabBarType type) {
    if (_listScreen.indexWhere((element) => element.type.index == type.index) ==
        -1) {
      _listScreen.add(
        TabScreen(widget: type.getScreen(), type: type),
      );
    }
  }
}

class MyNotification extends Notification {
  TabBarType typeTabBar;

  MyNotification(this.typeTabBar);
}
