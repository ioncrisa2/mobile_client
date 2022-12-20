import 'package:mobile_client/model/detail.dart';

class User {
  int id;
  String username;
  String email;
  String createdAt;
  String updatedAt;
  int roleId;
  Detail detail;

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    roleId = json['role_id'];
    detail =
        json['detail'] != null ? new Detail.fromJson(json['detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['email'] = this.email;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['role_id'] = this.roleId;
    if (this.detail != null) {
      data['detail'] = this.detail.toJson();
    }
    return data;
  }
}
