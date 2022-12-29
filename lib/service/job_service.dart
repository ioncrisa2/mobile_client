import 'package:dio/dio.dart' as Dio;
import 'package:mobile_client/Helper/dio.dart';
import 'package:mobile_client/Helper/token_storage.dart';
import 'package:mobile_client/model/job.dart';
import 'dart:convert';

class JobService {
  //ignore: missing_return
  Future<Jobs> getJobs() async {
    final token = await TokenStorage().readToken();
    final response = await dio().get('/jobs',
        options: Dio.Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        }));
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.toString());
      return Jobs.fromJson(jsonResponse);
    }
  }
}
