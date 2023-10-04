import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/base/base_cubit.dart';
import 'package:my_calendar/presentation/main_screen/ui/tabbar_item.dart';

import 'main_state.dart';

class MainCubit extends BaseCubit<MainState> {
  MainCubit() : super(InitialState());
  final BehaviorSubject<TabBarType> selectTabBarSubject =
      BehaviorSubject<TabBarType>.seeded(TabBarType.HOME);

  Stream<TabBarType> get selectTabBarStream => selectTabBarSubject.stream;

  void selectTab(TabBarType tab) {
    selectTabBarSubject.sink.add(tab);
  }

  void dispose() {
    selectTabBarSubject.close();
  }
}
