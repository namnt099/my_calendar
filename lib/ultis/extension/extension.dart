import 'dart:io';

import 'package:my_calendar/ultis/constants/app_constant.dart';


class FileModel {
  final File file;
  final int size;

  FileModel({required this.file, required this.size});
}
extension ConvertFile on File {
  FileModel convertToFiles() {
    return FileModel(
      size: lengthSync(),
      file: this,
    );
  }

  Future<File> moveToTmpDirectory(String newPath) async {
    try {
      return await rename(newPath);
    } catch (e) {
      final newFile = await copy(newPath);
      return newFile;
    }
  }

}
bool isVNPhone(String phone) {
  return RegExp(VN_PHONE).hasMatch(phone);
}
bool trueEmail(String email) {
  return RegExp(EMAIL_REGEX).hasMatch(email);
}