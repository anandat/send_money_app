import 'package:dio/dio.dart';

class DioClient {
  static Dio? _dio;

  static Dio get instance => _dio ??= Dio(
    BaseOptions(
      baseUrl: 'https://reqres.in',
      headers: {
        'x-api-key': 'reqres-free-v1',
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      connectTimeout: Duration(seconds: 5),
      receiveTimeout: Duration(seconds: 3),
      validateStatus: (status) => true,
    ),
  );


  static set instance(Dio dio) => _dio = dio;
}