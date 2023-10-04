// ignore: depend_on_referenced_packages
// ignore_for_file: avoid_dynamic_calls

import 'package:dio/dio.dart';
import 'package:my_calendar/data/exception/app_exception.dart';
import 'package:my_calendar/generated/l10n.dart';

class NetworkHandler {
  static AppException handleError(DioError error) {
    return _handleError(error);
  }

  static AppException _handleError(error) {
    if (error is! DioError) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    if (_isNetWorkError(error)) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    final parsedException = _parseError(error);
    final errorCode = error.response?.statusCode;
    if (error.response?.data['message'] != null) {
      return AppException(
        S.current.error,
        error.response?.data['message'] ?? S.current.something_went_wrong,
      );
    } else {
      return parsedException;
    }
  }

  static bool _isNetWorkError(DioError error) {
    final errorType = error.type;
    switch (errorType) {
      case DioErrorType.cancel:
        return true;
      case DioErrorType.connectTimeout:
        return true;
      case DioErrorType.receiveTimeout:
        return true;
      case DioErrorType.sendTimeout:
        return true;
      case DioErrorType.other:
        return true;
      case DioErrorType.response:
        return false;
      default:
        return true;
    }
  }

  static AppException _parseError(DioError error) {
    if (error.response?.data is! Map<String, dynamic>) {
      return AppException(S.current.error, S.current.something_went_wrong);
    }
    return AppException(S.current.error, S.current.something_went_wrong);
  }
}
