import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../app/constant.dart';

const String APPLICATION_JSON = "application/json";
const String CONTENT_TYPE = "content-type";
const String ACCEPT = "accept";
const String AUTHORIZATION = "authorization";
const String DEFAULT_LANGUAGE = "language";

class DioFactory {
  Future<Dio> getDio() async {
    Dio dio = Dio();
    const Duration _timeOut = Duration(milliseconds: 60 * 1000); // 1 min
    Map<String, String> headers = {
      CONTENT_TYPE: APPLICATION_JSON,
      ACCEPT: APPLICATION_JSON,
      AUTHORIZATION: Constant.token,
      DEFAULT_LANGUAGE: "en" // TODO: get lang from app prefs
    };
    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: _timeOut,
      receiveTimeout: _timeOut,
      headers: headers,
    );

    if (kReleaseMode) {
      print("release mode no logs");
    } else {
      dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
          responseBody: true,
        ),
      );
    }
    return dio;
  }
}
