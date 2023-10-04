// ignore: depend_on_referenced_packages
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/http.dart';
import 'package:my_calendar/data/response/horoscope_response.dart';
import 'package:my_calendar/ultis/constants/api_constant.dart';

part 'horo_service.g.dart';

@RestApi()
abstract class HoroClient {
  @factoryMethod
  factory HoroClient(Dio dio, {String baseUrl}) = _HoroClient;

  @GET(ApiConstants.LA_SO_my_calendar)
  Future<HoroScopeResponse> laSoTuVi(
    @Query('hoten') String? hoTen,
    @Query('gioitinh') String? gioiTinh,
    @Query('ngaysinh') String? ngaySinh,
    @Query('thangsinh') String? thangSinh,
    @Query('namsinh') String? namSinh,
    @Query('amlich') String? amLich,
    @Query('giosinh') String? gioSinh,
    @Query('muigio') String? muiGio,
    @Query('namxemhan') String? namXemHan,
    @Query('thamKhao') String? thamkhao,
  );


}
