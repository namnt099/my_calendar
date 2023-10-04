import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:my_calendar/ultis/extension/map_ext.dart';

import 'file_ext.dart';

Future<ModelAnh> pickAvatar() async {
  if (Platform.isIOS) {
    final resultMap = await pickImageFunc();
    final _path = resultMap.stringValueOrEmpty(PATH_OF_FILE);
    final _size = resultMap.intValue(SIZE_OF_FILE);
    return ModelAnh(path: _path, size: _size);
  } else {
    return pickAvatarOnAndroid();
  }
}

Future<ModelAnh> pickAvatarOnAndroid() async {
  const allowedExtensions = [
    FileExtensions.JPEG,
    FileExtensions.JPG,
    FileExtensions.PNG,
    FileExtensions.HEIC,
  ];
  try {
    final FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowedExtensions: allowedExtensions,
      type: FileType.custom,
    );
    if (result == null || result.files.isEmpty) {
      return ModelAnh(
        path: '',
        size: 0,
      );
    }
    if (!allowedExtensions.contains(
      result.files.first.extension?.toLowerCase().replaceAll('.', ''),
    )) {
      return ModelAnh(
        path: '',
        size: 0,
        notAcceptFile: true,
      );
    }
    return ModelAnh(
      path: result.files.first.path ?? '',
      size: result.files.first.size,
    );
  } on PlatformException catch (_) {
    //await MessageConfig.showDialogSetting();
    return ModelAnh(
      path: '',
      size: 0,
    );
  }
}

class ModelAnh {
  String path;
  int size;
  bool notAcceptFile;

  ModelAnh({
    required this.path,
    required this.size,
    this.notAcceptFile = false,
  });
}
