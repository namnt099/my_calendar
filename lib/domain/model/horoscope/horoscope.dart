import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:my_calendar/config/resources/styles.dart';

part 'horoscope.g.dart';

@HiveType(typeId: 1)
class HoroScope {
  @HiveField(1)
  ThienBan thienBan;
  @HiveField(2)
  List<ThapNhiCung> thapNhiCung;

  HoroScope({
    this.thienBan = const ThienBan(),
    this.thapNhiCung = const [],
  });
}

@HiveType(typeId: 2)
class ThienBan {
  @HiveField(1)
  final int gioiTinh;
  @HiveField(2)
  final String namNu;
  @HiveField(3)
  final ChiGioSinh chiGioSinh;
  @HiveField(4)
  final int canGioSinh;
  @HiveField(5)
  final String gioSinh;
  @HiveField(6)
  final int timeZone;
  @HiveField(7)
  final String today;
  @HiveField(8)
  final int ngayDuong;
  @HiveField(9)
  final int thangDuong;
  @HiveField(10)
  final int namDuong;
  @HiveField(11)
  final String ten;
  @HiveField(12)
  final int ngayAm;
  @HiveField(13)
  final int thangAm;
  @HiveField(14)
  final int namAm;
  @HiveField(15)
  final int thangNhuan;
  @HiveField(16)
  final int canThang;
  @HiveField(17)
  final int canNam;
  @HiveField(18)
  final int chiNam;
  @HiveField(19)
  final int chiThang;
  @HiveField(20)
  final String canThangTen;
  @HiveField(21)
  final String canNamTen;
  @HiveField(22)
  final String chiThangTen;
  @HiveField(23)
  final String chiNamTen;
  @HiveField(24)
  final int canNgay;
  @HiveField(25)
  final int chiNgay;
  @HiveField(26)
  final String canNgayTen;
  @HiveField(27)
  final String chiNgayTen;
  @HiveField(28)
  final String amDuongNamSinh;
  @HiveField(29)
  final String amDuongMenh;
  @HiveField(30)
  final int hanhCuc;
  @HiveField(31)
  final String tenCuc;
  @HiveField(32)
  final String menhChu;
  @HiveField(33)
  final String thanChu;
  @HiveField(34)
  final String menh;
  @HiveField(35)
  final String sinhKhac;
  @HiveField(36)
  final String banMenh;

  const ThienBan({
    this.gioiTinh = 1,
    this.namNu = '',
    this.chiGioSinh = const ChiGioSinh(),
    this.canGioSinh = -1,
    this.gioSinh = '',
    this.timeZone = -100,
    this.today = '',
    this.ngayDuong = 0,
    this.thangDuong = 0,
    this.namDuong = 0,
    this.ten = '',
    this.ngayAm = 0,
    this.thangAm = 0,
    this.namAm = 0,
    this.thangNhuan = 0,
    this.canThang = -100,
    this.canNam = -100,
    this.chiNam = -100,
    this.chiThang = -100,
    this.canThangTen = '',
    this.canNamTen = '',
    this.chiThangTen = '',
    this.chiNamTen = '',
    this.canNgay = -100,
    this.chiNgay = -100,
    this.canNgayTen = '',
    this.chiNgayTen = '',
    this.amDuongNamSinh = '',
    this.amDuongMenh = '',
    this.hanhCuc = -100,
    this.tenCuc = '',
    this.menhChu = '',
    this.thanChu = '',
    this.menh = '',
    this.sinhKhac = '',
    this.banMenh = '',
  });
}

@HiveType(typeId: 4)
class ChiGioSinh {
  @HiveField(1)
  final int id;
  @HiveField(2)
  final String tenChi;
  @HiveField(3)
  final String tenHanh;
  @HiveField(4)
  final String menhChu;
  @HiveField(5)
  final String thanChu;
  @HiveField(6)
  final int amDuong;

  const ChiGioSinh({
    this.id = -100,
    this.tenChi = '',
    this.tenHanh = '',
    this.menhChu = '',
    this.thanChu = '',
    this.amDuong = -100,
  });
}

@HiveType(typeId: 3)
class ThapNhiCung {
  @HiveField(1)
  int cungSo;
  @HiveField(2)
  String hanhCung;
  @HiveField(3)
  List<CungSao> cungSao;
  @HiveField(4)
  int cungAmDuong;
  @HiveField(5)
  String cungTen;
  @HiveField(6)
  bool cungThan;
  @HiveField(7)
  int cungDaiHan;
  @HiveField(8)
  String cungTieuHan;
  @HiveField(9)
  String cungChu;
  @HiveField(10)
  bool trietLo;
  @HiveField(11)
  bool tuanTrung;

  ThapNhiCung({
    this.cungSo = -100,
    this.hanhCung = '',
    this.cungSao = const [],
    this.cungAmDuong = -100,
    this.cungTen = '',
    this.cungThan = false,
    this.cungDaiHan = -100,
    this.cungTieuHan = '',
    this.cungChu = '',
    this.trietLo = false,
    this.tuanTrung = false,
  });

  List<CungSao> chinhTinh() {
    return cungSao.where((element) => element.saoLoai == 1).toList();
  }

  TextStyle styleChinhTinh() {
    return chinhTinh().first.styleSao(fontSize: 9);
  }

  String saoChinhTinh() {
    final List<CungSao> temp =
        cungSao.where((element) => element.saoLoai == 1).toList();
    String res = '';
    if (temp.length == 2) {
      String first = temp[0].saoTen.split(' ').first;
      String second = temp[1].saoTen.split(' ').first;
      if (temp.first.saoDacTinh.isNotEmpty) {
        res = '$first $second(${temp.first.saoDacTinh})';
        return '$res';
      } else {
        return '$first $second';
      }
    } else {
      String first = temp.first.saoTen.split(' ')[1];
      if (temp.first.saoDacTinh.isNotEmpty) {
        res = '${first}(${temp.first.saoDacTinh})';
        return '$res';
      } else {
        return '${temp.first.saoTen}';
      }
    }
  }

  List<CungSao> saoTot() {
    return cungSao
        .where(
          (element) =>
              element.vongTrangSinh == 0 &&
              element.saoLoai != 1 &&
              element.saoLoai < 10,
        )
        .toList();
  }

  List<CungSao> sao() {
    return cungSao.where((element) => element.vongTrangSinh == 0).toList();
  }

  Map<String, List<CungSao>> breakSao() {
    final Map<String, List<CungSao>> res = {};
    final temp = cungSao
        .where((element) => element.vongTrangSinh == 0 && element.saoLoai != 1)
        .toList();
    if (temp.length < 6) {
      final middle = 2;
      final first = {'first': temp.sublist(0, middle)};
      final second = {'second': temp.sublist(middle, temp.length)};
      res.addAll(first);
      res.addAll(second);
    } else if (temp.length < 9 && cungSao.length >= 6) {
      final pivot = 3;
      final first = {'first': temp.sublist(0, pivot)};
      final second = {'second': temp.sublist(pivot, pivot * 2)};
      final third = {'third': temp.sublist(pivot * 2, temp.length)};
      res.addAll(first);
      res.addAll(second);
      res.addAll(third);
    } else {
      final pivot = 3;
      final first = {'first': temp.sublist(0, pivot)};
      final second = {'second': temp.sublist(pivot, pivot * 2)};
      final third = {'third': temp.sublist(pivot * 2, pivot * 3)};
      final fourth = {'fourth': temp.sublist(pivot * 3, temp.length)};
      res.addAll(first);
      res.addAll(second);
      res.addAll(third);
      res.addAll(fourth);
    }

    return res;
  }

  List<CungSao> saoXau() {
    return cungSao
        .where(
          (element) =>
              element.vongTrangSinh == 0 &&
              element.saoLoai != 1 &&
              element.saoLoai > 10,
        )
        .toList();
  }

  CungSao vongThaiTue() {
    return cungSao.where((element) => element.vongThaiTue == 1).first;
  }

  CungSao vongTrangSinh() {
    return cungSao.where((element) => element.vongTrangSinh == 1).first;
  }

  CungSao vongLocTon() {
    return cungSao.where((element) => element.vongLocTon == 1).first;
  }
}

@HiveType(typeId: 5)
class CungSao {
  @HiveField(1)
  int saoId;
  @HiveField(2)
  String saoTen;
  @HiveField(3)
  String saoNguHanh;
  @HiveField(4)
  int saoLoai;
  @HiveField(5)
  String saoPhuongVi;
  @HiveField(6)
  dynamic saoAmDuong;
  @HiveField(7)
  int vongTrangSinh;
  @HiveField(8)
  String cssSao;
  @HiveField(9)
  String saoDacTinh;
  @HiveField(10)
  int vongThaiTue;
  @HiveField(11)
  int vongLocTon;
  @HiveField(12)
  String symbol;

  CungSao({
    this.saoId = -100,
    this.saoTen = '',
    this.saoNguHanh = '',
    this.saoLoai = -100,
    this.saoPhuongVi = '',
    this.saoAmDuong,
    this.vongTrangSinh = 0,
    this.cssSao = '',
    this.saoDacTinh = '',
    this.vongLocTon = 0,
    this.vongThaiTue = 0,
    this.symbol = '',
  });

  String layTen({bool first = false, bool lower = false}) {
    if(symbol.isEmpty) {
      if (saoDacTinh.isNotEmpty && !first) {
        return '${saoTen.toUpperCase()}($saoDacTinh)';
      } else if (first) {
        return saoTen.substring(0, 1).toLowerCase().capitalize!;
      }
      if (lower) {
        return saoTen.toLowerCase().capitalize!;
      }
      return saoTen.toLowerCase().capitalize!;
    }
    else {
      return symbol;
    }
  }

  TextStyle styleSao({
    double? fontSize,
    FontWeight? fontWeight,
  }) {
    switch (cssSao) {
      case 'hanhKim':
        return hanhKim(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      case 'hanhMoc':
        return hanhMoc(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      case 'hanhThuy':
        return hanhThuy(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      case 'hanhHoa':
        return hanhHoa(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      case 'hanhTho':
        return hanhTho(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
      default:
        return textNormalCustom(
          fontSize: fontSize,
          fontWeight: fontWeight,
        );
    }
  }
}
