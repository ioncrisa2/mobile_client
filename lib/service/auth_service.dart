import 'dart:convert';
import 'package:dio/dio.dart' as Dio;
import 'package:flutter/material.dart';
import 'package:mobile_client/Helper/dio.dart';
import 'package:mobile_client/Helper/token_storage.dart';
import 'package:mobile_client/model/user.dart';
import 'package:mobile_client/model/detail.dart';

class Auth extends ChangeNotifier {
  bool _isAuthenticated = false;
  User _user;
  Detail _detail;
  bool get isAuthenticated => _isAuthenticated;
  User get user => _user;
  Detail get detail => _detail;

  Future<Map> requestRegister(credentials) async {
    try {
      final response = await dio().post('/register', data: credentials);
      if (response.statusCode == 201) {
        return {'status': true};
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 422) {
        var _responseError = "";
        final _responseValidation = jsonDecode(e.response.toString())['errors'];
        // print(_responseValidation);
        for (var key in _responseValidation.keys) {
          _responseError += _responseValidation[key][0] + "\n";
        }

        return {'status': false, 'error_message': _responseError};
      }
    }
    return {
      'status': false,
      'error_message': 'something went wrong,please try again'
    };
  }

  Future<Map> requestLogin(credentials) async {
    try {
      final response = await dio().post('/login', data: credentials);
      if (response.statusCode == 200) {
        //store token to storage
        final token = json.decode(response.toString())['token'];
        await TokenStorage().saveToken(token);
        //state user is loggedin
        _isAuthenticated = true;
        notifyListeners();
        //response request
        return {
          'status': true,
        };
      }
    } on Dio.DioError catch (e) {
      if (e.response.statusCode == 401) {
        return {'status': false, 'error_message': 'Wrong email or password'};
      }
      if (e.response.statusCode == 422) {
        var _responseError = "";
        final _responseValidation = jsonDecode(e.response.toString())['errors'];
        // print(_responseValidation);
        for (var key in _responseValidation.keys) {
          _responseError += _responseValidation[key][0] + "\n";
        }

        return {'status': false, 'error_message': _responseError};
      }
    }
    return {
      'status': false,
      'error_message': 'something went wrong,please try again'
    };
  }

  Future<Map> requestLogout() async {
    final token = await TokenStorage().readToken();
    final res = await dio().post(
      '/logout',
      options: Dio.Options(
        headers: {'Authorization': 'Bearer $token'},
      ),
    );

    if (res.statusCode == 200) {
      await TokenStorage().deleteToken();
      _isAuthenticated = false;
      notifyListeners();
      return {'status': true};
    } else {
      return {'status': false, 'error_message': 'logout failed'};
    }
  }

  Future requestCheckLogin() async {
    try {
      final token = await TokenStorage().readToken();
      final res = await dio().get('/user',
          options: Dio.Options(
            headers: {'Authorization': 'Bearer $token'},
          ));

      if (res.statusCode == 200) {
        _user = User.fromJson(json.decode(res.toString())['data']);
        _detail =
            Detail.fromJson(json.decode(res.toString())['data']['detail']);
        _isAuthenticated = true;
        notifyListeners();
      }
    } on Dio.DioError catch (e) {
      _isAuthenticated = false;
      notifyListeners();
    }
  }
}
