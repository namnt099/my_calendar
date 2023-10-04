import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:my_calendar/ultis/extension/extension.dart';

enum PickerType {
  MEDIA_FILE,
  IMAGE_FILE,
  DOCUMENT,
  ALL,
  DOCUMENT_IMG,
  IMAGE_WITHOUT_HEIC,
  FULL,
}

class FileExtensions {
  static const String DOC = 'doc';
  static const String DOCX = 'docx';
  static const String PDF = 'pdf';
  static const String PNG = 'png';
  static const String JPEG = 'jpeg';
  static const String JPG = 'jpg';
  static const String XLSX = 'xlsx';
  static const String PPTX = 'pptx';
  static const String HEIC = 'heic';
}

const String TYPE_OF_FILE = 'type';
const String PATH_OF_FILE = 'path';
const String NAME_OF_FILE = 'name';
const String SIZE_OF_FILE = 'size';
const String EXTENSION_OF_FILE = 'extension';
const String VALID_FORMAT_OF_FILE = 'valid_format';
const String DOCUMENT_FILE = 'document_file';
const String MEDIA_VIDEO_FILE = 'media_video_file';
const String MEDIA_AUDIO_FILE = 'media_audio_file';
const String MEDIA_IMAGE_FILE = 'media_image_file';

Future<bool> handleFilePermission() async {
  final permission =
      Platform.isAndroid ? await Permission.storage.request() : true;
  if (permission == PermissionStatus.denied ||
      permission == PermissionStatus.permanentlyDenied) {
    return false;
  } else {
    return true;
  }
}

extension GetTypeByName on PickerType {
  List<String> get fileType {
    switch (this) {
      case PickerType.MEDIA_FILE:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF'
        ];
      case PickerType.IMAGE_FILE:
        return ['JPG', 'PNG', 'GIF', 'JPEG'];
      case PickerType.DOCUMENT:
        return ['DOC', 'DOCX', 'PDF', 'XLS', 'XLSX'];
      case PickerType.ALL:
        return [
          'MP4',
          'WEBM',
          'MP3',
          'WAV',
          'OGG',
          'PNG',
          'JPG',
          'JPEG',
          'GIF',
          'JPG',
          'PNG',
          'GIF',
          'JPEG',
          'DOC',
          'DOCX',
          'PDF',
          'XLS',
          'XLSX'
        ];
      case PickerType.DOCUMENT_IMG:
        return [
          'jpg',
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'png',
          'heic',
        ];
      case PickerType.IMAGE_WITHOUT_HEIC:
        return [
          'jpg',
          'pdf',
          'doc',
          'docx',
          'xls',
          'xlsx',
          'png',
        ];
      case PickerType.FULL:
        return [];
    }
  }
}

Future<bool> handlePhotosPermission() async {
  final permission = Platform.isIOS
      ? await Permission.photosAddOnly.request()
      : await Permission.storage.request();
  if (permission == PermissionStatus.denied ||
      permission == PermissionStatus.permanentlyDenied) {
    return false;
  } else {
    return true;
  }
}

Future<Map<String, dynamic>> pickImageFunc({
  ImageSource source = ImageSource.gallery,
}) async {
  final Map<String, dynamic> _resultMap = {
    PATH_OF_FILE: '',
    SIZE_OF_FILE: 0,
    EXTENSION_OF_FILE: '',
    VALID_FORMAT_OF_FILE: '',
    NAME_OF_FILE: '',
  };
  final permission = await handlePhotosPermission();
  if (permission) {
    final tempDirectory = await getTemporaryDirectory();
    final newImage = await ImagePicker().pickImage(source: source);
    if (newImage == null) {
      return _resultMap;
    }
    File file = File(newImage.path);
    if (Platform.isIOS) {
      file = await file.moveToTmpDirectory(
        '${tempDirectory.path}/${p.basename(newImage.path)}',
      );
    }
    final extension = (p.extension(file.path)).replaceAll('.', '');
    _resultMap[EXTENSION_OF_FILE] = extension;
    _resultMap[VALID_FORMAT_OF_FILE] =
        PickerType.IMAGE_FILE.fileType.contains(extension.toUpperCase());
    _resultMap[SIZE_OF_FILE] = file.lengthSync();
    _resultMap[PATH_OF_FILE] = file.path;
    _resultMap[NAME_OF_FILE] = p.basename(p.basename(file.path));
    return _resultMap;
  } else {
    //await MessageConfig.showDialogSetting();
    return {};
  }
}
