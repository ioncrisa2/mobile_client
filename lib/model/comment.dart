import 'user.dart';

class Comments {
  List<Comment> items;

  Comments({this.items});

  Comments.fromJson(json) {
    items = new List<Comment>();
    json.forEach((item) {
      items.add(Comment.fromJson(item));
    });
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['comments'] = this.items.map((e) => e.toJson()).toList();
    }
  }
}

class Comment {
  int id;
  int forumId;
  String body;
  int userId;
  String createdAt;
  User user;

  Comment(
      {this.id,
      this.forumId,
      this.body,
      this.userId,
      this.createdAt,
      this.user});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forumId = json['forum_id'];
    body = json['body'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['forum_id'] = this.forumId;
    data['body'] = this.body;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }
}
