import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/themes/app_theme.dart';

class SettingCubit {
  final BehaviorSubject<AppTheme> _selectAppThem = BehaviorSubject<AppTheme>();

  Stream<AppTheme> get selectAppThem => _selectAppThem.stream;

  void dispose() {
    _selectAppThem.close();
  }
}