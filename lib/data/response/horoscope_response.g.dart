// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HoroScopeResponse _$HoroScopeResponseFromJson(Map<String, dynamic> json) {
  return HoroScopeResponse(
    json['thienBan'] == null
        ? null
        : ThienBanResponse.fromJson(json['thienBan'] as Map<String, dynamic>),
    (json['thapNhiCung'] as List<dynamic>?)
        ?.map((e) => ThapNhiCungResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$HoroScopeResponseToJson(HoroScopeResponse instance) =>
    <String, dynamic>{
      'thienBan': instance.thienBan,
      'thapNhiCung': instance.thapNhiCung,
    };

ThienBanResponse _$ThienBanResponseFromJson(Map<String, dynamic> json) {
  return ThienBanResponse(
    json['gioiTinh'] as int?,
    json['namNu'] as String?,
    json['chiGioSinh'] == null
        ? null
        : ChiGioSinhResponse.fromJson(
            json['chiGioSinh'] as Map<String, dynamic>),
    json['canGioSinh'] as int?,
    json['gioSinh'] as String?,
    json['timeZone'] as int?,
    json['today'] as String?,
    json['ngayDuong'] as int?,
    json['thangDuong'] as int?,
    json['namDuong'] as int?,
    json['ten'] as String?,
    json['ngayAm'] as int?,
    json['thangAm'] as int?,
    json['namAm'] as int?,
    json['thangNhuan'] as int?,
    json['canThang'] as int?,
    json['canNam'] as int?,
    json['chiNam'] as int?,
    json['chiThang'] as int?,
    json['canThangTen'] as String?,
    json['canNamTen'] as String?,
    json['chiThangTen'] as String?,
    json['chiNamTen'] as String?,
    json['canNgay'] as int?,
    json['chiNgay'] as int?,
    json['canNgayTen'] as String?,
    json['chiNgayTen'] as String?,
    json['amDuongNamSinh'] as String?,
    json['amDuongMenh'] as String?,
    json['hanhCuc'] as int?,
    json['tenCuc'] as String?,
    json['menhChu'] as String?,
    json['thanChu'] as String?,
    json['menh'] as String?,
    json['sinhKhac'] as String?,
    json['banMenh'] as String?,
  );
}

Map<String, dynamic> _$ThienBanResponseToJson(ThienBanResponse instance) =>
    <String, dynamic>{
      'gioiTinh': instance.gioiTinh,
      'namNu': instance.namNu,
      'chiGioSinh': instance.chiGioSinh,
      'canGioSinh': instance.canGioSinh,
      'gioSinh': instance.gioSinh,
      'timeZone': instance.timeZone,
      'today': instance.today,
      'ngayDuong': instance.ngayDuong,
      'thangDuong': instance.thangDuong,
      'namDuong': instance.namDuong,
      'ten': instance.ten,
      'ngayAm': instance.ngayAm,
      'thangAm': instance.thangAm,
      'namAm': instance.namAm,
      'thangNhuan': instance.thangNhuan,
      'canThang': instance.canThang,
      'canNam': instance.canNam,
      'chiNam': instance.chiNam,
      'chiThang': instance.chiThang,
      'canThangTen': instance.canThangTen,
      'canNamTen': instance.canNamTen,
      'chiThangTen': instance.chiThangTen,
      'chiNamTen': instance.chiNamTen,
      'canNgay': instance.canNgay,
      'chiNgay': instance.chiNgay,
      'canNgayTen': instance.canNgayTen,
      'chiNgayTen': instance.chiNgayTen,
      'amDuongNamSinh': instance.amDuongNamSinh,
      'amDuongMenh': instance.amDuongMenh,
      'hanhCuc': instance.hanhCuc,
      'tenCuc': instance.tenCuc,
      'menhChu': instance.menhChu,
      'thanChu': instance.thanChu,
      'menh': instance.menh,
      'sinhKhac': instance.sinhKhac,
      'banMenh': instance.banMenh,
    };

ChiGioSinhResponse _$ChiGioSinhResponseFromJson(Map<String, dynamic> json) {
  return ChiGioSinhResponse(
    json['id'] as int?,
    json['tenChi'] as String?,
    json['tenHanh'] as String?,
    json['menhChu'] as String?,
    json['thanChu'] as String?,
    json['amDuong'] as int?,
  );
}

Map<String, dynamic> _$ChiGioSinhResponseToJson(ChiGioSinhResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'tenChi': instance.tenChi,
      'tenHanh': instance.tenHanh,
      'menhChu': instance.menhChu,
      'thanChu': instance.thanChu,
      'amDuong': instance.amDuong,
    };

ThapNhiCungResponse _$ThapNhiCungResponseFromJson(Map<String, dynamic> json) {
  return ThapNhiCungResponse(
    json['cungSo'] as int?,
    json['hanhCung'] as String?,
    (json['cungSao'] as List<dynamic>?)
        ?.map((e) => CungSaoResponse.fromJson(e as Map<String, dynamic>))
        .toList(),
    json['cungAmDuong'] as int?,
    json['cungTen'] as String?,
    json['cungThan'] as bool?,
    json['cungDaiHan'] as int?,
    json['cungTieuHan'] as String?,
    json['cungChu'] as String?,
    json['trietLo'] as bool?,
    json['tuanTrung'] as bool?,
  );
}

Map<String, dynamic> _$ThapNhiCungResponseToJson(
        ThapNhiCungResponse instance) =>
    <String, dynamic>{
      'cungSo': instance.cungSo,
      'hanhCung': instance.hanhCung,
      'cungSao': instance.cungSao,
      'cungAmDuong': instance.cungAmDuong,
      'cungTen': instance.cungTen,
      'cungThan': instance.cungThan,
      'cungDaiHan': instance.cungDaiHan,
      'cungTieuHan': instance.cungTieuHan,
      'cungChu': instance.cungChu,
      'trietLo': instance.trietLo,
      'tuanTrung': instance.tuanTrung,
    };

CungSaoResponse _$CungSaoResponseFromJson(Map<String, dynamic> json) {
  return CungSaoResponse(
    json['saoID'] as int?,
    json['saoTen'] as String?,
    json['saoNguHanh'] as String?,
    json['saoLoai'] as int?,
    json['saoPhuongVi'] as String?,
    json['saoAmDuong'],
    json['vongTrangSinh'] as int?,
    json['vongLocTon'] as int?,
    json['vongThaiTue'] as int?,
    json['cssSao'] as String?,
    json['saoDacTinh'] as String?,
    json['symbol'] as String?,
  );
}

Map<String, dynamic> _$CungSaoResponseToJson(CungSaoResponse instance) =>
    <String, dynamic>{
      'saoID': instance.saoID,
      'saoTen': instance.saoTen,
      'saoNguHanh': instance.saoNguHanh,
      'saoLoai': instance.saoLoai,
      'saoPhuongVi': instance.saoPhuongVi,
      'saoAmDuong': instance.saoAmDuong,
      'vongTrangSinh': instance.vongTrangSinh,
      'vongLocTon': instance.vongLocTon,
      'vongThaiTue': instance.vongThaiTue,
      'cssSao': instance.cssSao,
      'saoDacTinh': instance.saoDacTinh,
      'symbol': instance.symbol,
    };
