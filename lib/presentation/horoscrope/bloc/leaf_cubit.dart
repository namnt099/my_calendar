import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:my_calendar/config/base/base_cubit.dart';
import 'package:my_calendar/domain/locals/hive_local.dart';
import 'package:my_calendar/domain/model/devine.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/domain/repository/horoscope/horoscope_repository.dart';
import 'package:my_calendar/ultis/extension/string_ext.dart';

import 'leaf_state.dart';

class LeafCubit extends BaseCubit<LeafState> {
  LeafCubit() : super(InitialState()) {
    showContent();
    vongSao = [
      Divine(
        'VÒNG TỬ VI',
        '',
        onTap: () {
          indexSubject.sink.add(0);
        },
      ),
      Divine(
        'VÒNG LỘC TỒN',
        '',
        onTap: () {
          indexSubject.sink.add(1);
        },
      ),
      Divine(
        'VÒNG THÁI TUẾ',
        '',
        onTap: () {
          indexSubject.sink.add(2);
        },
      ),
      Divine(
        'CÁC VÒNG SAO',
        '',
        onTap: () {
          indexSubject.sink.add(3);
        },
      ),
    ];
  }

  HoroRepository get horoRepo => Get.find();
  final gioSinhSubject = BehaviorSubject.seeded('Giờ sinh');
  final ngaySinhSubject = BehaviorSubject.seeded('Ngày sinh');
  final horoSubject = BehaviorSubject<HoroScope>();
  final indexSubject = BehaviorSubject.seeded(0);
  late final List<Divine> vongSao;

  Future<void> laSoTuVi(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String thamKhao,
    String namXem,
  ) async {
    showLoading();
    final result = await horoRepo.laSoTuVi(
      hoTen,
      gioiTinh,
      ngaySinh,
      thangSinh,
      namSinh,
      amLich,
      gioSinh,
      muiGio,
      namXem,
      thamKhao,
    );
    result.when(
      success: (res) {
        horoSubject.sink.add(res);
        giaiDoan(
          hoTen,
          gioiTinh,
          ngaySinh,
          thangSinh,
          namSinh,
          amLich,
          gioSinh,
          muiGio,
          namXem,
        );
        daiVan(
          hoTen,
          gioiTinh,
          ngaySinh,
          thangSinh,
          namSinh,
          amLich,
          gioSinh,
          muiGio,
          namXem,
        );
        vanHan(
          hoTen,
          gioiTinh,
          ngaySinh,
          thangSinh,
          namSinh,
          amLich,
          gioSinh,
          muiGio,
          namXem,
        );
        HiveLocal.saveHoroScope(res);
      },
      error: (error) {
        showError();
      },
    );
  }

  final List<dynamic> chuGiai = [];
  final List<Map<String, dynamic>> dataGiaiDoan = [];

  Future<void> giaiDoan(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String namXem,
  ) async {
    var headers = {
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'Accept-Language': 'vi',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Referer': 'http://127.0.0.1:8000/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'Sec-GPC': '1',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest'
    };

    final http.Client client = http.Client();
    final url = amLich == 'on'
        ? 'http://localhost:8000/api_giaidoan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXem&thamkhao=1&amlich=on'
        : 'http://localhost:8000/api_giaidoan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXem&thamkhao=1';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      showContent();
      String jsonRaw = json.decode(utf8.decode(response.bodyBytes));
      final data = json.decode(jsonRaw) as List<dynamic>;
      convertList(data);
      await HiveLocal.saveGiaiDoan(jsonRaw);
    } else {
      showError();
      print(response.reasonPhrase);
    }
  }

  void convertList(List data) {
    final result = <Map<String, dynamic>>[];
    data.forEach((bigElement) {
      bigElement as List;
      Map<String, dynamic> gd = {};
      for (int i = 0; i < bigElement.length; i++) {
        gd['title$i'] =
            bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
      }
      result.add(gd);
    });
    dataGiaiDoan.addAll(result);
  }

  void convertListDaiVan(List data) {
    final result = <Map<String, dynamic>>[];
    data.forEach((bigElement) {
      bigElement as List;
      Map<String, dynamic> gd = {};
      for (int i = 0; i < bigElement.length; i++) {
        gd['title$i'] =
            bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
      }
      result.add(gd);
    });
  }

  void convertListVanHan(List data) {
    final result = <Map<String, dynamic>>[];
    data.forEach((bigElement) {
      bigElement as List;
      Map<String, dynamic> gd = {};
      for (int i = 0; i < bigElement.length; i++) {
        gd['title$i'] =
            bigElement[i].toString().parseHtml().replaceAll('<br>', '\n');
      }
      result.add(gd);
    });
  }

  static String converToRaw(List<Map<String, dynamic>> data) {
    final bigList = [];

    data.forEach((element) {
      var sList = [];
      sList.addAll(element.values);
      bigList.add(sList);
    });
    return json.encode(bigList);
  }

  Future<void> daiVan(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String namXem,
  ) async {
    var headers = {
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'Accept-Language': 'vi',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Referer': 'http://127.0.0.1:8000/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'Sec-GPC': '1',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest'
    };

    final http.Client client = http.Client();
    final url = amLich == 'on'
        ? 'http://localhost:8000/api_daivan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=2022&thamkhao=1&amlich=on'
        : 'http://localhost:8000/api_daivan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=2022&thamkhao=1';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      showContent();
      String jsonRaw = json.decode(utf8.decode(response.bodyBytes));
      final data = json.decode(jsonRaw) as List<dynamic>;
      convertListDaiVan(data);
      await HiveLocal.saveDaiVan(jsonRaw);
    } else {
      showError();
      print(response.reasonPhrase);
    }
  }

  Future<void> vanHan(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String namXem,
  ) async {
    var headers = {
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'Accept-Language': 'vi',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Referer': 'http://127.0.0.1:8000/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'Sec-GPC': '1',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest'
    };

    final http.Client client = http.Client();
    final url = amLich == 'on'
        ? 'http://localhost:8000/api_vanhan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXem&thamkhao=1&amlich=on'
        : 'http://localhost:8000/api_vanhan?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXem&thamkhao=1';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      showContent();
      String jsonRaw = json.decode(utf8.decode(response.bodyBytes));
      final data = json.decode(jsonRaw) as List<dynamic>;
      convertListVanHan(data);
      await HiveLocal.saveVanHan(jsonRaw);
    } else {
      showError();
      print(response.reasonPhrase);
    }
  }

  Future<void> trondoi(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String namXemHan,
  ) async {
    var headers = {
      'Accept': 'application/json, text/javascript, */*; q=0.01',
      'Accept-Language': 'vi',
      'Cache-Control': 'no-cache',
      'Connection': 'keep-alive',
      'Pragma': 'no-cache',
      'Referer': 'http://127.0.0.1:8000/',
      'Sec-Fetch-Dest': 'empty',
      'Sec-Fetch-Mode': 'cors',
      'Sec-Fetch-Site': 'same-origin',
      'Sec-GPC': '1',
      'User-Agent':
          'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/108.0.0.0 Safari/537.36',
      'X-Requested-With': 'XMLHttpRequest'
    };
    showLoading();
    final http.Client client = http.Client();
    final url = amLich == 'on'
        ? 'http://localhost:8000/api_trondoi?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXemHan&thamkhao=1&amlich=on'
        : 'http://localhost:8000/api_trondoi?hoten=$hoTen&gioitinh=$gioiTinh&ngaysinh=$ngaySinh&than'
            'gsinh=$thangSinh&namsinh=$namSinh&giosinh=$gioSinh&muigio=7&namxemhan=$namXemHan&thamkhao=1';
    final response = await client.get(
      Uri.parse(url),
      headers: headers,
    );

    if (response.statusCode == 200) {
      showContent();
      await saveFile('${hoTen}_${ngaySinh}_${thangSinh}_$namSinh.xlsx',
              response.bodyBytes)
          .then(
            (value) => Get.snackbar(
              'Thành công',
              'Tải tệp thành công ' +
                  '${hoTen}_${ngaySinh}_${thangSinh}_$namSinh.xlsx',
              snackPosition: SnackPosition.BOTTOM,
            ),
          )
          .onError(
            (error, stackTrace) => Get.snackbar(
              'Thất bại',
              'Không thể tải xuống',
              snackPosition: SnackPosition.BOTTOM,
            ),
          );
    } else {
      showError();
      print(response.reasonPhrase);
    }
  }

  Future<bool> saveFile(String fileName, dynamic dataSave) async {
    bool success = false;
    if (Platform.isAndroid) {
      try {
        const String dir = '/storage/emulated/0/Download';
        await writeFile(dir, fileName, dataSave);
        success = true;
      } catch (e) {
        final tempDir = await getExternalStorageDirectory();
        await writeFile(tempDir?.path ?? '', fileName, dataSave);
        success = true;
      }
    } else if (Platform.isIOS) {
      final tempDir = await getApplicationDocumentsDirectory();
      print(tempDir.path ?? '');
      await writeFile(tempDir.path, fileName, dataSave);
      success = true;
    }
    print(success);

    return success;
  }

  Future<void> writeFile(String path, String _fileName, dynamic data) async {
    int count = 1;
    final List<String> listName = _fileName.split('.');
    String nameFile = '';
    for (var index = 0; index < listName.length - 1; index++) {
      if (index != listName.length - 2) {
        nameFile += '${listName[index]}.';
      } else {
        nameFile += listName[index];
      }
    }
    final String extension = listName.last;
    String fullPath = '$path/$_fileName';
    File file = File(fullPath);
    while (file.existsSync()) {
      fullPath = '$path/$nameFile($count).$extension';
      count += 1;
      file = File(fullPath);
    }
    final raf = file.openSync(mode: FileMode.write);
    raf.writeFromSync(data);
    await raf.close();
  }
}
