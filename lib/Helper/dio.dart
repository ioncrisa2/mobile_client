import 'package:dio/dio.dart';

Dio dio() {
  return new Dio(
    BaseOptions(
      baseUrl: 'https://forumandjobserver.info/api',
      connectTimeout: 10000,
      receiveTimeout: 3000,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
}
