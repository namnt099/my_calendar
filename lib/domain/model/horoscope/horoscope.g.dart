// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horoscope.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HoroScopeAdapter extends TypeAdapter<HoroScope> {
  @override
  final int typeId = 1;

  @override
  HoroScope read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HoroScope(
      thienBan: fields[1] as ThienBan,
      thapNhiCung: (fields[2] as List).cast<ThapNhiCung>(),
    );
  }

  @override
  void write(BinaryWriter writer, HoroScope obj) {
    writer
      ..writeByte(2)
      ..writeByte(1)
      ..write(obj.thienBan)
      ..writeByte(2)
      ..write(obj.thapNhiCung);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HoroScopeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThienBanAdapter extends TypeAdapter<ThienBan> {
  @override
  final int typeId = 2;

  @override
  ThienBan read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThienBan(
      gioiTinh: fields[1] as int,
      namNu: fields[2] as String,
      chiGioSinh: fields[3] as ChiGioSinh,
      canGioSinh: fields[4] as int,
      gioSinh: fields[5] as String,
      timeZone: fields[6] as int,
      today: fields[7] as String,
      ngayDuong: fields[8] as int,
      thangDuong: fields[9] as int,
      namDuong: fields[10] as int,
      ten: fields[11] as String,
      ngayAm: fields[12] as int,
      thangAm: fields[13] as int,
      namAm: fields[14] as int,
      thangNhuan: fields[15] as int,
      canThang: fields[16] as int,
      canNam: fields[17] as int,
      chiNam: fields[18] as int,
      chiThang: fields[19] as int,
      canThangTen: fields[20] as String,
      canNamTen: fields[21] as String,
      chiThangTen: fields[22] as String,
      chiNamTen: fields[23] as String,
      canNgay: fields[24] as int,
      chiNgay: fields[25] as int,
      canNgayTen: fields[26] as String,
      chiNgayTen: fields[27] as String,
      amDuongNamSinh: fields[28] as String,
      amDuongMenh: fields[29] as String,
      hanhCuc: fields[30] as int,
      tenCuc: fields[31] as String,
      menhChu: fields[32] as String,
      thanChu: fields[33] as String,
      menh: fields[34] as String,
      sinhKhac: fields[35] as String,
      banMenh: fields[36] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ThienBan obj) {
    writer
      ..writeByte(36)
      ..writeByte(1)
      ..write(obj.gioiTinh)
      ..writeByte(2)
      ..write(obj.namNu)
      ..writeByte(3)
      ..write(obj.chiGioSinh)
      ..writeByte(4)
      ..write(obj.canGioSinh)
      ..writeByte(5)
      ..write(obj.gioSinh)
      ..writeByte(6)
      ..write(obj.timeZone)
      ..writeByte(7)
      ..write(obj.today)
      ..writeByte(8)
      ..write(obj.ngayDuong)
      ..writeByte(9)
      ..write(obj.thangDuong)
      ..writeByte(10)
      ..write(obj.namDuong)
      ..writeByte(11)
      ..write(obj.ten)
      ..writeByte(12)
      ..write(obj.ngayAm)
      ..writeByte(13)
      ..write(obj.thangAm)
      ..writeByte(14)
      ..write(obj.namAm)
      ..writeByte(15)
      ..write(obj.thangNhuan)
      ..writeByte(16)
      ..write(obj.canThang)
      ..writeByte(17)
      ..write(obj.canNam)
      ..writeByte(18)
      ..write(obj.chiNam)
      ..writeByte(19)
      ..write(obj.chiThang)
      ..writeByte(20)
      ..write(obj.canThangTen)
      ..writeByte(21)
      ..write(obj.canNamTen)
      ..writeByte(22)
      ..write(obj.chiThangTen)
      ..writeByte(23)
      ..write(obj.chiNamTen)
      ..writeByte(24)
      ..write(obj.canNgay)
      ..writeByte(25)
      ..write(obj.chiNgay)
      ..writeByte(26)
      ..write(obj.canNgayTen)
      ..writeByte(27)
      ..write(obj.chiNgayTen)
      ..writeByte(28)
      ..write(obj.amDuongNamSinh)
      ..writeByte(29)
      ..write(obj.amDuongMenh)
      ..writeByte(30)
      ..write(obj.hanhCuc)
      ..writeByte(31)
      ..write(obj.tenCuc)
      ..writeByte(32)
      ..write(obj.menhChu)
      ..writeByte(33)
      ..write(obj.thanChu)
      ..writeByte(34)
      ..write(obj.menh)
      ..writeByte(35)
      ..write(obj.sinhKhac)
      ..writeByte(36)
      ..write(obj.banMenh);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThienBanAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ChiGioSinhAdapter extends TypeAdapter<ChiGioSinh> {
  @override
  final int typeId = 4;

  @override
  ChiGioSinh read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ChiGioSinh(
      id: fields[1] as int,
      tenChi: fields[2] as String,
      tenHanh: fields[3] as String,
      menhChu: fields[4] as String,
      thanChu: fields[5] as String,
      amDuong: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, ChiGioSinh obj) {
    writer
      ..writeByte(6)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.tenChi)
      ..writeByte(3)
      ..write(obj.tenHanh)
      ..writeByte(4)
      ..write(obj.menhChu)
      ..writeByte(5)
      ..write(obj.thanChu)
      ..writeByte(6)
      ..write(obj.amDuong);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ChiGioSinhAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class ThapNhiCungAdapter extends TypeAdapter<ThapNhiCung> {
  @override
  final int typeId = 3;

  @override
  ThapNhiCung read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ThapNhiCung(
      cungSo: fields[1] as int,
      hanhCung: fields[2] as String,
      cungSao: (fields[3] as List).cast<CungSao>(),
      cungAmDuong: fields[4] as int,
      cungTen: fields[5] as String,
      cungThan: fields[6] as bool,
      cungDaiHan: fields[7] as int,
      cungTieuHan: fields[8] as String,
      cungChu: fields[9] as String,
      trietLo: fields[10] as bool,
      tuanTrung: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, ThapNhiCung obj) {
    writer
      ..writeByte(11)
      ..writeByte(1)
      ..write(obj.cungSo)
      ..writeByte(2)
      ..write(obj.hanhCung)
      ..writeByte(3)
      ..write(obj.cungSao)
      ..writeByte(4)
      ..write(obj.cungAmDuong)
      ..writeByte(5)
      ..write(obj.cungTen)
      ..writeByte(6)
      ..write(obj.cungThan)
      ..writeByte(7)
      ..write(obj.cungDaiHan)
      ..writeByte(8)
      ..write(obj.cungTieuHan)
      ..writeByte(9)
      ..write(obj.cungChu)
      ..writeByte(10)
      ..write(obj.trietLo)
      ..writeByte(11)
      ..write(obj.tuanTrung);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ThapNhiCungAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CungSaoAdapter extends TypeAdapter<CungSao> {
  @override
  final int typeId = 5;

  @override
  CungSao read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CungSao(
      saoId: fields[1] as int,
      saoTen: fields[2] as String,
      saoNguHanh: fields[3] as String,
      saoLoai: fields[4] as int,
      saoPhuongVi: fields[5] as String,
      saoAmDuong: fields[6] as dynamic,
      vongTrangSinh: fields[7] as int,
      cssSao: fields[8] as String,
      saoDacTinh: fields[9] as String,
      vongLocTon: fields[11] as int,
      vongThaiTue: fields[10] as int,
      symbol: fields[12] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CungSao obj) {
    writer
      ..writeByte(12)
      ..writeByte(1)
      ..write(obj.saoId)
      ..writeByte(2)
      ..write(obj.saoTen)
      ..writeByte(3)
      ..write(obj.saoNguHanh)
      ..writeByte(4)
      ..write(obj.saoLoai)
      ..writeByte(5)
      ..write(obj.saoPhuongVi)
      ..writeByte(6)
      ..write(obj.saoAmDuong)
      ..writeByte(7)
      ..write(obj.vongTrangSinh)
      ..writeByte(8)
      ..write(obj.cssSao)
      ..writeByte(9)
      ..write(obj.saoDacTinh)
      ..writeByte(10)
      ..write(obj.vongThaiTue)
      ..writeByte(11)
      ..write(obj.vongLocTon)
      ..writeByte(12)
      ..write(obj.symbol);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CungSaoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
