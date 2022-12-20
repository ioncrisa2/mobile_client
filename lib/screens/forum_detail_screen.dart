import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/forum_detail.dart';
import 'package:mobile_client/service/forum_service.dart';

class ForumDetailScreen extends StatefulWidget {
  final int id;
  ForumDetailScreen({Key key, this.id}) : super(key: key);

  @override
  State<ForumDetailScreen> createState() => _ForumDetailScreenState();
}

class _ForumDetailScreenState extends State<ForumDetailScreen> {
  Future<ForumDetail> _forumDetailFuture;

  @override
  void initState() {
    super.initState();
    _forumDetailFuture = ForumService().detailForum(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: FutureBuilder(
          future: _forumDetailFuture,
          builder: (ctx, ss) {
            if (ss.hasData) {
              return Column(
                children: <Widget>[
                  titleSection(
                    ss.data.title,
                    ss.data.user.username,
                    ss.data.category,
                  ),
                ],
              );
            } else if (ss.hasError) {
              return Text("${ss.error}");
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }

  Widget titleSection(String title, String username, String category) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Column(
        children: <Widget>[
          new Text(title,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold)),
          new Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconWithText(Icons.book, category),
                new IconWithText(Icons.people, username),
              ],
            ),
          ),
          new Divider()
        ],
      ),
    );
  }
}
