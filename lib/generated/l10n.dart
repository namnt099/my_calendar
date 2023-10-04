// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again later.`
  String get something_went_wrong {
    return Intl.message(
      'Something went wrong. Please try again later.',
      name: 'something_went_wrong',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Error Network`
  String get error_network {
    return Intl.message(
      'Error Network',
      name: 'error_network',
      desc: '',
      args: [],
    );
  }

  /// `No internet`
  String get no_internet {
    return Intl.message(
      'No internet',
      name: 'no_internet',
      desc: '',
      args: [],
    );
  }

  /// `Retry`
  String get retry {
    return Intl.message(
      'Retry',
      name: 'retry',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Calendar`
  String get calendar {
    return Intl.message(
      'Calendar',
      name: 'calendar',
      desc: '',
      args: [],
    );
  }

  /// `Event`
  String get event {
    return Intl.message(
      'Event',
      name: 'event',
      desc: '',
      args: [],
    );
  }

  /// `Horoscope`
  String get horoscope {
    return Intl.message(
      'Horoscope',
      name: 'horoscope',
      desc: '',
      args: [],
    );
  }

  /// `Explore`
  String get explore {
    return Intl.message(
      'Explore',
      name: 'explore',
      desc: '',
      args: [],
    );
  }

  /// `Tiberian Calendar`
  String get tibe {
    return Intl.message(
      'Tiberian Calendar',
      name: 'tibe',
      desc: '',
      args: [],
    );
  }

  /// `Send`
  String get send {
    return Intl.message(
      'Send',
      name: 'send',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Enter your email`
  String get enter_email {
    return Intl.message(
      'Enter your email',
      name: 'enter_email',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format email`
  String get invalid_email {
    return Intl.message(
      'Invalid format email',
      name: 'invalid_email',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email`
  String get please_email {
    return Intl.message(
      'Please enter your email',
      name: 'please_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter your password`
  String get enter_pass {
    return Intl.message(
      'Enter your password',
      name: 'enter_pass',
      desc: '',
      args: [],
    );
  }

  /// `Invalid format password`
  String get invalid_pass {
    return Intl.message(
      'Invalid format password',
      name: 'invalid_pass',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your password`
  String get please_pass {
    return Intl.message(
      'Please enter your password',
      name: 'please_pass',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Do not have an account? `
  String get no_account {
    return Intl.message(
      'Do not have an account? ',
      name: 'no_account',
      desc: '',
      args: [],
    );
  }

  /// `Bạn đã có tài khoản? `
  String get has_account {
    return Intl.message(
      'Bạn đã có tài khoản? ',
      name: 'has_account',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `or`
  String get or {
    return Intl.message(
      'or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get setting {
    return Intl.message(
      'Setting',
      name: 'setting',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share {
    return Intl.message(
      'Share',
      name: 'share',
      desc: '',
      args: [],
    );
  }

  /// `Friend`
  String get friend {
    return Intl.message(
      'Friend',
      name: 'friend',
      desc: '',
      args: [],
    );
  }

  /// `Scan QR`
  String get qr {
    return Intl.message(
      'Scan QR',
      name: 'qr',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Blue`
  String get xanh {
    return Intl.message(
      'Blue',
      name: 'xanh',
      desc: '',
      args: [],
    );
  }

  /// `Pink`
  String get hong {
    return Intl.message(
      'Pink',
      name: 'hong',
      desc: '',
      args: [],
    );
  }

  /// `Yellow`
  String get vang {
    return Intl.message(
      'Yellow',
      name: 'vang',
      desc: '',
      args: [],
    );
  }

  /// `Seasons`
  String get cac_mua {
    return Intl.message(
      'Seasons',
      name: 'cac_mua',
      desc: '',
      args: [],
    );
  }

  /// `Spring`
  String get xuan {
    return Intl.message(
      'Spring',
      name: 'xuan',
      desc: '',
      args: [],
    );
  }

  /// `Summer`
  String get ha {
    return Intl.message(
      'Summer',
      name: 'ha',
      desc: '',
      args: [],
    );
  }

  /// `Autumn`
  String get thu {
    return Intl.message(
      'Autumn',
      name: 'thu',
      desc: '',
      args: [],
    );
  }

  /// `Winter`
  String get dong_mua {
    return Intl.message(
      'Winter',
      name: 'dong_mua',
      desc: '',
      args: [],
    );
  }

  /// `Lunar New Year`
  String get tet_nguyen_dam {
    return Intl.message(
      'Lunar New Year',
      name: 'tet_nguyen_dam',
      desc: '',
      args: [],
    );
  }

  /// `Valentine`
  String get le_tinh_nhan {
    return Intl.message(
      'Valentine',
      name: 'le_tinh_nhan',
      desc: '',
      args: [],
    );
  }

  /// `International Women Day`
  String get ngay_quoc_te_phu_nu {
    return Intl.message(
      'International Women Day',
      name: 'ngay_quoc_te_phu_nu',
      desc: '',
      args: [],
    );
  }

  /// `Gio To Hung Vuong`
  String get gio_to_hung_vuong {
    return Intl.message(
      'Gio To Hung Vuong',
      name: 'gio_to_hung_vuong',
      desc: '',
      args: [],
    );
  }

  /// `International Labor Day`
  String get ngay_quoc_te_lao_dong {
    return Intl.message(
      'International Labor Day',
      name: 'ngay_quoc_te_lao_dong',
      desc: '',
      args: [],
    );
  }

  /// `International Children's Day`
  String get ngay_quoc_te_thieu_nhi {
    return Intl.message(
      'International Children\'s Day',
      name: 'ngay_quoc_te_thieu_nhi',
      desc: '',
      args: [],
    );
  }

  /// `National Day`
  String get ngay_quoc_khanh {
    return Intl.message(
      'National Day',
      name: 'ngay_quoc_khanh',
      desc: '',
      args: [],
    );
  }

  /// `Mid Autumn`
  String get tet_trung_thu {
    return Intl.message(
      'Mid Autumn',
      name: 'tet_trung_thu',
      desc: '',
      args: [],
    );
  }

  /// `Viet Nam Women Day`
  String get ngay_phu_nu_viet_nam {
    return Intl.message(
      'Viet Nam Women Day',
      name: 'ngay_phu_nu_viet_nam',
      desc: '',
      args: [],
    );
  }

  /// `Halloween`
  String get ngay_halloween {
    return Intl.message(
      'Halloween',
      name: 'ngay_halloween',
      desc: '',
      args: [],
    );
  }

  /// `Viet Nam Teacher Day`
  String get ngay_nha_giao_viet_nam {
    return Intl.message(
      'Viet Nam Teacher Day',
      name: 'ngay_nha_giao_viet_nam',
      desc: '',
      args: [],
    );
  }

  /// `Noel`
  String get ngay_le_giang_sinh {
    return Intl.message(
      'Noel',
      name: 'ngay_le_giang_sinh',
      desc: '',
      args: [],
    );
  }

  /// `Ngày lễ`
  String get ngay_le {
    return Intl.message(
      'Ngày lễ',
      name: 'ngay_le',
      desc: '',
      args: [],
    );
  }

  /// `Setting color`
  String get setting_color {
    return Intl.message(
      'Setting color',
      name: 'setting_color',
      desc: '',
      args: [],
    );
  }

  /// `Season`
  String get setting_season {
    return Intl.message(
      'Season',
      name: 'setting_season',
      desc: '',
      args: [],
    );
  }

  /// `Default`
  String get default_s {
    return Intl.message(
      'Default',
      name: 'default_s',
      desc: '',
      args: [],
    );
  }

  /// `Setting theme`
  String get setting_theme {
    return Intl.message(
      'Setting theme',
      name: 'setting_theme',
      desc: '',
      args: [],
    );
  }

  /// `Media`
  String get media {
    return Intl.message(
      'Media',
      name: 'media',
      desc: '',
      args: [],
    );
  }

  /// `Content library`
  String get content_library {
    return Intl.message(
      'Content library',
      name: 'content_library',
      desc: '',
      args: [],
    );
  }

  /// `Term of use`
  String get term {
    return Intl.message(
      'Term of use',
      name: 'term',
      desc: '',
      args: [],
    );
  }

  /// `Privacy policy`
  String get privacy {
    return Intl.message(
      'Privacy policy',
      name: 'privacy',
      desc: '',
      args: [],
    );
  }

  /// `Member`
  String get member {
    return Intl.message(
      'Member',
      name: 'member',
      desc: '',
      args: [],
    );
  }

  /// `Update information`
  String get update_info {
    return Intl.message(
      'Update information',
      name: 'update_info',
      desc: '',
      args: [],
    );
  }

  /// `User`
  String get user_name {
    return Intl.message(
      'User',
      name: 'user_name',
      desc: '',
      args: [],
    );
  }

  /// `Birthday`
  String get birthday {
    return Intl.message(
      'Birthday',
      name: 'birthday',
      desc: '',
      args: [],
    );
  }

  /// `Hour`
  String get hour {
    return Intl.message(
      'Hour',
      name: 'hour',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `Address`
  String get address {
    return Intl.message(
      'Address',
      name: 'address',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Success`
  String get success {
    return Intl.message(
      'Success',
      name: 'success',
      desc: '',
      args: [],
    );
  }

  /// `Fail`
  String get fail {
    return Intl.message(
      'Fail',
      name: 'fail',
      desc: '',
      args: [],
    );
  }

  /// `Update profile success`
  String get update_profile_success {
    return Intl.message(
      'Update profile success',
      name: 'update_profile_success',
      desc: '',
      args: [],
    );
  }

  /// `Update profile fail`
  String get update_profile_fail {
    return Intl.message(
      'Update profile fail',
      name: 'update_profile_fail',
      desc: '',
      args: [],
    );
  }

  /// `No data`
  String get no_data {
    return Intl.message(
      'No data',
      name: 'no_data',
      desc: '',
      args: [],
    );
  }

  /// `Unknow`
  String get unknow {
    return Intl.message(
      'Unknow',
      name: 'unknow',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'vi'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
