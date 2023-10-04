// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'horo_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _HoroClient implements HoroClient {
  _HoroClient(
    this._dio, {
    this.baseUrl,
  });

  final Dio _dio;

  String? baseUrl;

  @override
  Future<HoroScopeResponse> laSoTuVi(
    hoTen,
    gioiTinh,
    ngaySinh,
    thangSinh,
    namSinh,
    amLich,
    gioSinh,
    muiGio,
    namXemHan,
    thamkhao,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'hoten': hoTen,
      r'gioitinh': gioiTinh,
      r'ngaysinh': ngaySinh,
      r'thangsinh': thangSinh,
      r'namsinh': namSinh,
      r'amlich': amLich,
      r'giosinh': gioSinh,
      r'muigio': muiGio,
      r'namxemhan': namXemHan,
      r'thamKhao': thamkhao,
    };
    queryParameters.removeWhere((k, v) => v == null);
    final _data = <String, dynamic>{};
    final _result = await _dio
        .fetch<Map<String, dynamic>>(_setStreamType<HoroScopeResponse>(Options(
      method: 'GET',
      headers: <String, dynamic>{},
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/api_laso',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = HoroScopeResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
