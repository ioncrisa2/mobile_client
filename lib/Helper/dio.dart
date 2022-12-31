import 'package:dio/dio.dart';

Dio dio() {
  return new Dio(
    BaseOptions(
      baseUrl: 'http://10.0.2.2:8000/api',
      connectTimeout: 10000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}
