import 'dart:async';
import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:queue/queue.dart';
import 'package:my_calendar/domain/model/account/user.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/presentation/horoscrope/bloc/leaf_cubit.dart';
import 'package:my_calendar/ultis/extension/string_ext.dart';

class HiveLocal {
  static const USER_INFO = 'USER_INFO';
  static const HORO_SCOPE = 'HORO_SCOPE';
  static const GIAI_DOAN = 'GIAI_DOAN';
  static const DAI_VAN = 'DAI_VAN';
  static const VAN_HAN = 'VAN_HAN';
  static late Box<LoginUser> _userBox;
  static late Box<HoroScope> _horoBox;
  static late Box<String> _giaiDoan;
  static late Box<String> _daiVan;
  static late Box<String> _vanHan;

  static Future<void> init() async {
    Hive.registerAdapter(LoginUserAdapter());
    Hive.registerAdapter(HoroScopeAdapter());
    Hive.registerAdapter(ThienBanAdapter());
    Hive.registerAdapter(ThapNhiCungAdapter());
    Hive.registerAdapter(CungSaoAdapter());
    Hive.registerAdapter(ChiGioSinhAdapter());
    final que = Queue(parallel: 5);
    unawaited(que.add(() async => _userBox = await Hive.openBox(USER_INFO)));
    unawaited(que.add(() async => _horoBox = await Hive.openBox(HORO_SCOPE)));
    unawaited(que.add(() async => _giaiDoan = await Hive.openBox(GIAI_DOAN)));
    unawaited(que.add(() async => _daiVan = await Hive.openBox(DAI_VAN)));
    unawaited(que.add(() async => _vanHan = await Hive.openBox(VAN_HAN)));
  }

  static Future<void> saveDataUser(LoginUser user) async {
    await _userBox.clear();
    await _userBox.add(user);
  }

  static Future<void> saveGiaiDoan(String data) async {
    await _giaiDoan.add(data);
  }

  static List<List<Map<String, dynamic>>> getGiaiDoan() {
    final data = _giaiDoan.values;
    final result = <List<Map<String, dynamic>>>[];
    if (data.isNotEmpty) {
      final dataList = data.toList();
      final temp = <Map<String, dynamic>>[];
      dataList.forEach((text) {
        final data = json.decode(text) as List<dynamic>;
        data.forEach((bigElement) {
          bigElement as List;
          Map<String, dynamic> gd = {};
          for (int i = 0; i < bigElement.length; i++) {
            gd['title$i'] =
                bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
          }
          temp.add(gd);
        });
        result.add(temp);
      });
    }
    return result;
  }

  static Future<void> saveDaiVan(String data,
      {int? index, bool edit = false}) async {
    final temp = _daiVan.values.toList();
    if (index != null && edit) {
      temp.removeAt(index);
      temp.insert(index, data);
      await _daiVan.clear();
      await _daiVan.addAll(temp);
    } else {
      if (edit) {
        await _daiVan.clear();
        temp.removeLast();
        temp.add(data);
        await _daiVan.addAll(temp);
      } else {
        await _daiVan.add(data);
      }
    }
  }

  static List<List<Map<String, dynamic>>> getDaiVan() {
    final data = _daiVan.values;
    final result = <List<Map<String, dynamic>>>[];
    if (data.isNotEmpty) {
      final dataList = data.toList();
      dataList.forEach((text) {
        final data = json.decode(text) as List<dynamic>;
        final temp = <Map<String, dynamic>>[];
        data.forEach((bigElement) {
          bigElement as List;
          Map<String, dynamic> gd = {};
          for (int i = 0; i < bigElement.length; i++) {
            gd['title$i'] =
                bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
          }
          temp.add(gd);
        });
        result.add(temp);
      });
    }
    return result;
  }

  static Future<void> saveVanHan(String data,
      {int? index, bool edit = false}) async {
    final temp = _vanHan.values.toList();
    if (index != null && edit) {
      temp.removeAt(index);
      temp.insert(index, data);
      await _vanHan.clear();
      await _vanHan.addAll(temp);
    } else {
      if (edit) {
        await _vanHan.clear();
        temp.removeLast();
        temp.add(data);
        await _vanHan.addAll(temp);
      } else {
        await _vanHan.add(data);
      }
    }
  }

  static List<List<Map<String, dynamic>>> getVanHan() {
    final data = _vanHan.values;
    final result = <List<Map<String, dynamic>>>[];
    if (data.isNotEmpty) {
      final dataList = data.toList();
      final temp = <Map<String, dynamic>>[];
      dataList.forEach((text) {
        final data = json.decode(text) as List<dynamic>;
        data.forEach((bigElement) {
          bigElement as List;
          Map<String, dynamic> gd = {};
          for (int i = 0; i < bigElement.length; i++) {
            gd['title$i'] =
                bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
          }
          temp.add(gd);
        });
        result.add(temp);
      });
    }
    return result;
  }

  static Future<void> giaiDoanXoa(int index) async {
    await _giaiDoan.deleteAt(index);
  }

  static Future<void> saveHoroScope(HoroScope data) async {
    await _horoBox.add(data);
  }

  static Future<void> deleteAt(int index) async {
    await _horoBox.deleteAt(index);
    await _vanHan.deleteAt(index);
    await _daiVan.deleteAt(index);
  }

  static Future<void> clearHoroScope() async {
    await _horoBox.clear();
  }

  static List<HoroScope> getHoroScope() {
    final data = _horoBox.values;
    if (data.isNotEmpty) {
      return data.toList();
    }
    return [];
  }

  static void clearData() {
    _userBox.clear();
  }

  static LoginUser? getDataUser() {
    final data = _userBox.values;
    if (data.isNotEmpty) {
      return data.first;
    }
    return null;
  }
}
