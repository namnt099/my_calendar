// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginUserAdapter extends TypeAdapter<LoginUser> {
  @override
  final int typeId = 0;

  @override
  LoginUser read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginUser(
      displayName: fields[0] as String,
      email: fields[1] as String,
      photoUrl: fields[2] as String,
      uid: fields[3] as String,
      token: fields[4] as String,
      address: fields[5] as String?,
      birthday: fields[6] as String?,
      hour: fields[7] as String?,
      phone: fields[8] as String?,
      networkImage: fields[9] as bool?,
    );
  }

  @override
  void write(BinaryWriter writer, LoginUser obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.displayName)
      ..writeByte(1)
      ..write(obj.email)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.uid)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.birthday)
      ..writeByte(7)
      ..write(obj.hour)
      ..writeByte(8)
      ..write(obj.phone)
      ..writeByte(9)
      ..write(obj.networkImage);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginUserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
