import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/comment.dart';
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
                  questionWidget(
                    ss.data.title,
                    ss.data.body,
                    ss.data.user.username,
                    ss.data.category,
                    ss.data.createdAt,
                  ),
                  Expanded(child: UserComments(commentList: ss.data.comments))
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

  Widget questionWidget(
    String title,
    String body,
    String username,
    String category,
    String createdAt,
  ) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: new Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Text(
            title,
            textScaleFactor: 1.5,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Container(
            child: Row(
              children: [
                new Icon(Icons.people),
                SizedBox(width: 5),
                new Text(
                  'By $username',
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 15.0),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          new Text(
            body,
            textScaleFactor: 1.2,
            textAlign: TextAlign.justify,
          ),
          new Padding(
            padding: EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new IconWithText(Icons.book, category),
                new IconWithText(Icons.timer, createdAt),
              ],
            ),
          ),
          new Divider()
        ],
      ),
    );
  }
}

class UserComments extends StatefulWidget {
  final commentList;
  UserComments({Key key, this.commentList}) : super(key: key);

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  Comments _commentsList;

  @override
  void initState() {
    super.initState();
    _commentsList = widget.commentList;
  }

  void selectedPopupMenu(String value, String name) {
    String message;
    if (value == 'edit') {
      message = "You have selected edit for $name";
    } else if (value == 'delete') {
      message = "You have selected delete for $name";
    } else {
      message = "not implemented!!";
    }

    print(message);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _commentsList.items.length,
      itemBuilder: (ctx, index) {
        var data = _commentsList.items[index];
        return ListTile(
          title: Text('${data.body}', textAlign: TextAlign.justify),
          subtitle: Text('${data.createdAt} - oleh ${data.user.username}'),
          trailing: PopupMenuButton(
            icon: Icon(Icons.info),
            onSelected: (String value) {
              print("You click popup menu!!");
              selectedPopupMenu(value, data.body);
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 'edit',
                  child: Text('Edit'),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Text('Delete'),
                ),
              ];
            },
          ),
        );
      },
    );
  }
}
