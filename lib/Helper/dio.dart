import 'package:dio/dio.dart';

Dio dio() {
  return new Dio(
    BaseOptions(
      baseUrl: 'http://192.168.100.137:8000/api',
      connectTimeout: 10000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}
