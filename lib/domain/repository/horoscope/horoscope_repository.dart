import 'package:my_calendar/domain/model/horoscope/horoscope.dart';

import '../../../data/result/result.dart';

mixin HoroRepository {
  Future<Result<HoroScope>> laSoTuVi(
    String hoTen,
    String gioiTinh,
    String ngaySinh,
    String thangSinh,
    String namSinh,
    String amLich,
    String gioSinh,
    String muiGio,
    String namXemHan,
    String thamKhao,
  );

}
