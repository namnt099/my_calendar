import 'package:json_annotation/json_annotation.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';

part 'horoscope_response.g.dart';

@JsonSerializable()
class HoroScopeResponse {
  ThienBanResponse? thienBan;
  List<ThapNhiCungResponse>? thapNhiCung;

  HoroScopeResponse(this.thienBan, this.thapNhiCung);

  factory HoroScopeResponse.fromJson(Map<String, dynamic> json) =>
      _$HoroScopeResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$HoroScopeResponseToJson(this);

  HoroScope toDomain() => HoroScope(
        thienBan: thienBan?.toDomain() ?? const ThienBan(),
        thapNhiCung: thapNhiCung?.map((e) => e.toDomain()).toList() ?? [],
      );
}

@JsonSerializable()
class ThienBanResponse {
  int? gioiTinh;
  String? namNu;
  ChiGioSinhResponse? chiGioSinh;
  int? canGioSinh;
  String? gioSinh;
  int? timeZone;
  String? today;
  int? ngayDuong;
  int? thangDuong;
  int? namDuong;
  String? ten;
  int? ngayAm;
  int? thangAm;
  int? namAm;
  int? thangNhuan;
  int? canThang;
  int? canNam;
  int? chiNam;
  int? chiThang;
  String? canThangTen;
  String? canNamTen;
  String? chiThangTen;
  String? chiNamTen;
  int? canNgay;
  int? chiNgay;
  String? canNgayTen;
  String? chiNgayTen;
  String? amDuongNamSinh;
  String? amDuongMenh;
  int? hanhCuc;
  String? tenCuc;
  String? menhChu;
  String? thanChu;
  String? menh;
  String? sinhKhac;
  String? banMenh;

  ThienBanResponse(
    this.gioiTinh,
    this.namNu,
    this.chiGioSinh,
    this.canGioSinh,
    this.gioSinh,
    this.timeZone,
    this.today,
    this.ngayDuong,
    this.thangDuong,
    this.namDuong,
    this.ten,
    this.ngayAm,
    this.thangAm,
    this.namAm,
    this.thangNhuan,
    this.canThang,
    this.canNam,
    this.chiNam,
    this.chiThang,
    this.canThangTen,
    this.canNamTen,
    this.chiThangTen,
    this.chiNamTen,
    this.canNgay,
    this.chiNgay,
    this.canNgayTen,
    this.chiNgayTen,
    this.amDuongNamSinh,
    this.amDuongMenh,
    this.hanhCuc,
    this.tenCuc,
    this.menhChu,
    this.thanChu,
    this.menh,
    this.sinhKhac,
    this.banMenh,
  );

  factory ThienBanResponse.fromJson(Map<String, dynamic> json) =>
      _$ThienBanResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$ThienBanResponseToJson(this);

  ThienBan toDomain() => ThienBan(
        gioiTinh: gioiTinh ?? 0,
        namNu: namNu ?? '',
        chiGioSinh: chiGioSinh?.toDomain() ?? const ChiGioSinh(),
        canGioSinh: canGioSinh ?? -100,
        gioSinh: gioSinh ?? '',
        timeZone: timeZone ?? -100,
        today: today ?? '',
        ngayDuong: ngayDuong ?? -100,
        thangDuong: thangDuong ?? -100,
        namDuong: namDuong ?? -100,
        ten: ten ?? '',
        ngayAm: ngayAm ?? -100,
        thangAm: thangAm ?? -100,
        namAm: namAm ?? -100,
        thangNhuan: thangNhuan ?? 0,
        canThang: canThang ?? -100,
        canNam: canNam ?? -100,
        chiNam: chiNam ?? -100,
        chiThang: chiThang ?? -100,
        canThangTen: canThangTen ?? '',
        canNamTen: canNamTen ?? '',
        chiThangTen: chiThangTen ?? '',
        chiNamTen: chiNamTen ?? '',
        canNgay: canNgay ?? -100,
        chiNgay: chiNgay ?? -100,
        canNgayTen: canNamTen ?? '',
        chiNgayTen: chiNgayTen ?? '',
        amDuongNamSinh: amDuongNamSinh ?? '',
        amDuongMenh: amDuongMenh ?? '',
        hanhCuc: hanhCuc ?? -100,
        tenCuc: tenCuc ?? '',
        menhChu: menhChu ?? '',
        thanChu: thanChu ?? '',
        menh: menh ?? '',
        sinhKhac: sinhKhac ?? '',
        banMenh: banMenh ?? '',
      );
}

@JsonSerializable()
class ChiGioSinhResponse {
  int? id;
  String? tenChi;
  String? tenHanh;
  String? menhChu;
  String? thanChu;
  int? amDuong;

  ChiGioSinhResponse(
    this.id,
    this.tenChi,
    this.tenHanh,
    this.menhChu,
    this.thanChu,
    this.amDuong,
  );

  factory ChiGioSinhResponse.fromJson(Map<String, dynamic> json) =>
      _$ChiGioSinhResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$ChiGioSinhResponseToJson(this);

  ChiGioSinh toDomain() => ChiGioSinh(
        id: id ?? -100,
        tenChi: tenChi ?? '',
        tenHanh: tenHanh ?? '',
        menhChu: menhChu ?? '',
        thanChu: thanChu ?? '',
        amDuong: amDuong ?? 0,
      );
}

@JsonSerializable()
class ThapNhiCungResponse {
  int? cungSo;
  String? hanhCung;
  List<CungSaoResponse>? cungSao;
  int? cungAmDuong;
  String? cungTen;
  bool? cungThan;
  int? cungDaiHan;
  String? cungTieuHan;
  String? cungChu;
  bool? trietLo;
  bool? tuanTrung;

  ThapNhiCungResponse(
    this.cungSo,
    this.hanhCung,
    this.cungSao,
    this.cungAmDuong,
    this.cungTen,
    this.cungThan,
    this.cungDaiHan,
    this.cungTieuHan,
    this.cungChu,
    this.trietLo,
    this.tuanTrung,
  );

  factory ThapNhiCungResponse.fromJson(Map<String, dynamic> json) =>
      _$ThapNhiCungResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$ThapNhiCungResponseToJson(this);

  ThapNhiCung toDomain() => ThapNhiCung(
        cungSo: cungSo ?? -100,
        hanhCung: hanhCung ?? '',
        cungSao: cungSao?.map((e) => e.toDomain()).toList() ?? [],
        cungAmDuong: cungAmDuong ?? -100,
        cungTen: cungTen ?? '',
        cungThan: cungThan ?? false,
        cungDaiHan: cungDaiHan ?? -100,
        cungTieuHan: cungTieuHan ?? '',
        cungChu: cungChu ?? '',
        trietLo: trietLo ?? false,
        tuanTrung: tuanTrung ?? false,
      );
}

@JsonSerializable()
class CungSaoResponse {
  int? saoID;
  String? saoTen;
  String? saoNguHanh;
  int? saoLoai;
  String? saoPhuongVi;
  dynamic? saoAmDuong;
  int? vongTrangSinh;
  int? vongLocTon;
  int? vongThaiTue;
  String? cssSao;
  String? saoDacTinh;
  String? symbol;

  CungSaoResponse(
    this.saoID,
    this.saoTen,
    this.saoNguHanh,
    this.saoLoai,
    this.saoPhuongVi,
    this.saoAmDuong,
    this.vongTrangSinh,
    this.vongLocTon,
    this.vongThaiTue,
    this.cssSao,
    this.saoDacTinh,
    this.symbol,
  );

  factory CungSaoResponse.fromJson(Map<String, dynamic> json) =>
      _$CungSaoResponseFromJson(json);

  Map<String?, dynamic> toJson() => _$CungSaoResponseToJson(this);

  CungSao toDomain() => CungSao(
        saoId: saoID ?? -100,
        saoTen: saoTen ?? '',
        saoNguHanh: saoNguHanh ?? '',
        saoLoai: saoLoai ?? -100,
        saoPhuongVi: saoPhuongVi ?? '',
        saoAmDuong: saoAmDuong,
        vongTrangSinh: vongTrangSinh ?? 0,
        vongLocTon: vongLocTon ?? 0,
        vongThaiTue: vongThaiTue ?? 0,
        cssSao: cssSao ?? '',
        saoDacTinh: saoDacTinh ?? '',
        symbol: symbol ?? '',
      );
}
