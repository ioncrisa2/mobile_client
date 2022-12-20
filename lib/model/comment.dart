import 'user.dart';

class Comments {
  List<Comment> items;

  Comments({this.items});

  Comments.fromJson(json) {
    items = <Comment>[];
    json.forEach((item) {
      items.add(Comment.fromJson(item));
    });
  }
}

class Comment {
  int id;
  int forumId;
  String body;
  int userId;
  String createdAt;

  Comment({this.id, this.forumId, this.body, this.userId, this.createdAt});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    forumId = json['forum_id'];
    body = json['body'];
    userId = json['user_id'];
    createdAt = json['created_at'];
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
