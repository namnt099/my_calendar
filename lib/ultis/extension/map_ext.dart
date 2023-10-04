import 'dart:io';

extension MapParse on Map {
  String stringValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is String) {
      return vl;
    }
    return '';
  }

  bool boolValue(String key) {
    final vl = this[key];
    if (vl != null && vl is bool) {
      return vl;
    }
    return false;
  }

  int intValue(String key) {
    final vl = this[key];
    if (vl != null && vl is int) {
      return vl;
    }
    return 0;
  }

  List<dynamic> arrayValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is List) {
      return vl;
    }
    return [];
  }

  Map<String, dynamic> mapValueOrEmpty(String key) {
    final vl = this[key];
    if (vl != null && vl is Map) {
      return vl as Map<String, dynamic>;
    }
    return {};
  }

  String compareWithZero(String key) {
    final int value = intValue(key);
    if (value == 0) {
      return '';
    }
    return value.toString();
  }

  String getStringValue(String key) {
    String vl = '';
    try {
      vl = this[key];
    } catch (_) {}
    return vl;
  }

  List<File> getFileValue(String key) {
    List<File> vl = [];
    try {
      vl = this[key];
    } catch (_) {}
    return vl;
  }
}
