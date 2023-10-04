import 'package:hive/hive.dart';

part 'user.g.dart';
@HiveType(typeId: 0)
class LoginUser {
  @HiveField(0)
  String displayName = '';
  @HiveField(1)
  String email = '';
  @HiveField(2)
  String photoUrl = '';
  @HiveField(3)
  String uid = '';
  @HiveField(4)
  String token = '';
  @HiveField(5)
  String? address = '';
  @HiveField(6)
  String? birthday = '';
  @HiveField(7)
  String? hour = '';
  @HiveField(8)
  String? phone = '';
  @HiveField(9)
  bool? networkImage;

  LoginUser({
    this.displayName = '',
    this.email = '',
    this.photoUrl = '',
    this.uid = '',
    this.token = '',
    this.address = '',
    this.birthday = '',
    this.hour = '',
    this.phone = '',
    this.networkImage = true,
  });
  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    'email': email,
    'photoUrl': photoUrl,
    'uid': uid,
    'token': token,
    'address': address,
    'birthday': birthday,
    'hour': hour,
    'phone': phone,
    'networkImage': networkImage,
  };
}
