import 'user.dart';

class Forums {
  List<Forum> forums;

  Forums({this.forums});

  Forums.fromJson(json) {
    forums = <Forum>[];
    json['data'].forEach((item) {
      forums.add(Forum.fromJson(item));
    });
  }
}

class Forum {
  int id;
  String title;
  String body;
  String category;
  String createdAt;
  User user;

  Forum(
      {this.id,
      this.title,
      this.body,
      this.category,
      this.createdAt,
      this.user});

  factory Forum.fromJson(Map<String, dynamic> json) {
    return Forum(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      category: json['category'],
      createdAt: json['created_at'],
      user: User.fromJson(
        json['user'],
      ),
    );
  }
}
