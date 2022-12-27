import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:mobile_client/Helper/dio.dart';
import 'package:mobile_client/model/comment.dart';
import 'package:mobile_client/model/forum.dart';
import 'package:mobile_client/Helper/token_storage.dart';
import 'package:mobile_client/model/forum_detail.dart';
import 'package:mobile_client/model/user.dart';

class ForumService {
  // ignore: missing_return
  Future<Forums> getForums() async {
    final response = await dio().get('/forums');

    if (response.statusCode == 200) {
      return Forums.fromJson(json.decode(response.toString()));
    }
  }

  // ignore: missing_return
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

  Future postForum(data) async {
    try {
      final token = await TokenStorage().readToken();
      final res = await dio().post(
        '/forums',
        data: data,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (res.statusCode == 201) {
        return {'status': true};
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 422) {
        var _responseError = "";
        final _responseValidation = jsonDecode(e.response.toString())['errors'];
        for (var key in _responseValidation.keys) {
          _responseError += _responseValidation[key][0] + "\n";
        }
        return {'status': false, 'error_message': _responseError};
      }
    }
    return {
      'status': false,
      'error_message': 'something wrong, please try again'
    };
  }

  Future editForum(data, id) async {
    try {
      final token = await TokenStorage().readToken();
      final res = await dio().put(
        '/forums/$id',
        data: data,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (res.statusCode == 200) {
        return {'status': true};
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 403) {
        return {'status': false, 'error_message': 'Not Authorized user'};
      }
      if (e.response.statusCode == 422) {
        var _responseError = "";
        final _responseValidation = jsonDecode(e.response.toString())['errors'];
        for (var key in _responseValidation.keys) {
          _responseError += _responseValidation[key][0] + "\n";
        }
        return {'status': false, 'error_message': _responseError};
      }
    }
    return {
      'status': false,
      'error_message': 'something wrong, please try again'
    };
  }

  Future postComment(data, id) async {
    try {
      final token = await TokenStorage().readToken();
      final res = await dio().post(
        '/forums/$id/comments',
        data: data,
        options: Dio.Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (res.statusCode == 201) {
        return {'status': true};
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 422) {
        var _responseError = "";
        final _responseValidation = jsonDecode(e.response.toString())['errors'];
        for (var key in _responseValidation.keys) {
          _responseError += _responseValidation[key][0] + "\n";
        }
        return {'status': false, 'error_message': _responseError};
      }
    }
    return {
      'status': false,
      'error_message': 'something wrong, please try again'
    };
  }
}
