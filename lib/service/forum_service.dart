import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:mobile_client/Helper/dio.dart';
import 'package:mobile_client/model/comment.dart';
import 'package:mobile_client/model/forum.dart';
import 'package:mobile_client/Helper/token_storage.dart';
import 'package:mobile_client/model/forum_detail.dart';
import 'package:mobile_client/model/user.dart';

class ForumService {
  Future<Forums> getForums() async {
    final response = await dio().get('/forums');

    if (response.statusCode == 200) {
      return Forums.fromJson(json.decode(response.toString()));
    }
  }

  Future<ForumDetail> detailForum(id) async {
    final response = await dio().get('/forums/$id',
        options: Dio.Options(headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json'
        }));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.toString())['data'];

      // print(jsonResponse);
      final result = ForumDetail.toJson(jsonResponse);
      return result;
    }
  }
}
