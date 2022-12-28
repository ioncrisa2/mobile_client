import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/comment.dart';
import 'package:mobile_client/model/forum_detail.dart';
import 'package:mobile_client/model/user.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/screens/forum_form_screen.dart';
import 'package:mobile_client/screens/login_screen.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:mobile_client/service/forum_service.dart';
import 'package:provider/provider.dart';

import 'comment_form_screen.dart';

class ForumDetailScreen extends StatefulWidget {
  final int id;
  ForumDetailScreen({Key key, this.id}) : super(key: key);

  @override
  State<ForumDetailScreen> createState() => _ForumDetailScreenState();
}

class _ForumDetailScreenState extends State<ForumDetailScreen> {
  Future<ForumDetail> _forumDetailFuture;

  _getUserData() => context.read<Auth>().user;
  _isAuthenticated() => context.read<Auth>().isAuthenticated;

  @override
  void initState() {
    super.initState();
    _forumDetailFuture = ForumService().detailForum(widget.id);
    _getUserData();
  }

  @override
  Widget build(BuildContext context) {
    final user = _getUserData();

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
                    ss.data.user.id,
                    user.id,
                    ss.data.id,
                  ),
                  if (_isAuthenticated())
                    Expanded(
                      child: UserComments(
                        commentList: ss.data.comments,
                        forumId: ss.data.id,
                        user: user,
                      ),
                    ),
                  Container(
                    child: RichText(
                      text: TextSpan(
                        text: "Komentar Baru",
                        style: TextStyle(
                            color: Colors.blueAccent.shade400,
                            fontSize: 16,
                            decoration: TextDecoration.underline),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            if (user != null && _isAuthenticated()) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      CommentFormScreen(forumId: ss.data.id),
                                ),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          },
                      ),
                    ),
                  ),
                  if (!_isAuthenticated())
                    RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        children: [
                          TextSpan(text: 'untuk melihat komentar silahkan '),
                          TextSpan(
                            text: 'login',
                            style: TextStyle(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
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
      drawer: AppDrawer(),
    );
  }

  Widget questionWidget(String title, String body, String username,
      String category, String createdAt, int user, int userID, int itemID) {
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
                if (_isAuthenticated())
                  if (user != null)
                    if (user == userID)
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForumFormScreen(id: itemID),
                            ),
                          );
                        },
                      )
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
  final int forumId;
  final user;
  UserComments({Key key, this.commentList, this.forumId, this.user})
      : super(key: key);

  @override
  State<UserComments> createState() => _UserCommentsState();
}

class _UserCommentsState extends State<UserComments> {
  Comments _commentsList;
  int _forumId;

  _getUserData() => context.read<Auth>().user;
  _isAuthenticated() => context.read<Auth>().isAuthenticated;

  @override
  void initState() {
    super.initState();
    _commentsList = widget.commentList;
    _forumId = widget.forumId;
    _isAuthenticated();
    _getUserData();
  }

  void selectedPopupMenu(String value, dynamic data) {
    String message;
    if (value == 'edit') {
      message = "You have selected edit for $data";
    } else if (value == 'delete') {
      message = "You have selected delete for $data";
    } else {
      message = "not implemented!!";
    }

    print(message);
  }

  @override
  Widget build(BuildContext context) {
    final user = _getUserData();
    return _commentsList.items.isNotEmpty
        ? ListView.builder(
            itemCount: _commentsList.items.length,
            itemBuilder: (ctx, index) {
              var data = _commentsList.items[index];
              return Column(
                children: [
                  ListTile(
                    title: Text('${data.body}', textAlign: TextAlign.justify),
                    subtitle:
                        Text('${data.createdAt} - oleh ${data.user.username}'),
                    trailing: _isAuthenticated() && data.userId == user.id
                        ? PopupMenuButton(
                            icon: Icon(Icons.info),
                            onSelected: (String value) {
                              selectedPopupMenu(value, data.id);
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
                          )
                        : null,
                  ),
                ],
              );
            },
          )
        : RichText(
            text: TextSpan(
              style: TextStyle(color: Colors.black, fontSize: 15.0),
              children: [
                TextSpan(text: 'Belum ada komentar, '),
                TextSpan(
                  text: 'tambahkan komentar',
                  style: TextStyle(color: Colors.blue),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      if (_isAuthenticated()) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentFormScreen(forumId: _forumId),
                          ),
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginScreen(),
                          ),
                        );
                      }
                    },
                ),
              ],
            ),
          );
  }
}
