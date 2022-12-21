import 'package:mobile_client/model/comment.dart';

import 'user.dart';

class ForumDetail {
  int id;
  String title;
  String body;
  String category;
  String createdAt;
  String updatedAt;
  User user;
  Comments comments;

  ForumDetail({
    this.id,
    this.title,
    this.body,
    this.category,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.comments,
  });

  ForumDetail.toJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    category = json['category'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    comments = json['comments'] != null
        ? new Comments.fromJson(json['comments'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['body'] = this.body;
    data['category'] = this.category;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    if (this.comments != null) {
      data['comments'] = this.comments.toJson();
    }
    return data;
  }
}
