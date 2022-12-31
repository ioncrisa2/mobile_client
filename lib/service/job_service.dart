import 'package:dio/dio.dart' as Dio;
import 'package:flutter/foundation.dart';
import 'package:mobile_client/Helper/dio.dart';
import 'package:mobile_client/Helper/token_storage.dart';
import 'package:mobile_client/model/job.dart';
import 'dart:convert';

import 'package:mobile_client/model/job_detail.dart';

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
      final res = Jobs.fromJson(jsonResponse);
      print(res);
      return res;
    }
  }

  //ignore: missing_return
  Future<JobDetail> detailJob(id) async {
    final token = await TokenStorage().readToken();
    final response = await dio().get(
      '/jobs/$id',
      options: Dio.Options(
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token'
        },
      ),
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.toString())['data'];

      final result = JobDetail.fromJson(jsonResponse);
      debugPrint(result.toString());
      return result;
    }
  }
}
