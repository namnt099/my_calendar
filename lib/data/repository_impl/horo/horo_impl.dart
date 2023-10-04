import 'package:my_calendar/data/response/horoscope_response.dart';
import 'package:my_calendar/data/result/result.dart';
import 'package:my_calendar/data/service/horo_service.dart';
import 'package:my_calendar/domain/model/horoscope/horoscope.dart';
import 'package:my_calendar/domain/repository/horoscope/horoscope_repository.dart';

class HoroRepositoryImpl implements HoroRepository {
  final HoroClient horoClient;

  HoroRepositoryImpl(this.horoClient);

  @override
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
      String thamKhao) {
    return runCatchingAsync<HoroScopeResponse, HoroScope>(
      () => horoClient.laSoTuVi(
        hoTen,
        gioiTinh,
        ngaySinh,
        thangSinh,
        namSinh,
        amLich,
        gioSinh,
        muiGio,
        namXemHan,
        thamKhao,
      ),
      (res) => res.toDomain(),
    );
  }
}
