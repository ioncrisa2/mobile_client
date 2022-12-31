import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/comment.dart';
import 'package:mobile_client/model/forum_detail.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/screens/forum_form_screen.dart';
import 'package:mobile_client/screens/home_screen.dart';
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

  void checkIfLoggedId() async {
    await Provider.of<Auth>(context, listen: false).requestCheckLogin();
  }

  _getUserData() => context.read<Auth>().user;
  _isAuthenticated() => context.read<Auth>().isAuthenticated;

  @override
  void initState() {
    super.initState();
    checkIfLoggedId();
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
          builder: (ctx, index) {
            final comment = index.data;
            if (index.hasData) {
              return Column(
                children: <Widget>[
                  questionWidget(
                    comment.title,
                    comment.body,
                    comment.user.username,
                    comment.category,
                    comment.createdAt,
                    comment.user.id,
                    user.id,
                    comment.id,
                  ),
                  if (_isAuthenticated())
                    Expanded(
                      child: UserComments(
                        commentList: comment.comments,
                        forumId: comment.id,
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
                                      CommentFormScreen(forumId: comment.id),
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
                ],
              );
            } else if (index.hasError) {
              return Text("${index.error}");
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
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ForumFormScreen(id: itemID),
                                ),
                              );
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              final res =
                                  await ForumService().deleteForum(widget.id);

                              if (res['status'] == true) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ],
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

  Future deleteComment({forum, comment}) async {
    final res = await ForumService().deleteComment(
      forumId: forum,
      commentId: comment,
    );

    if (res['status'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForumDetailScreen(id: widget.forumId),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _commentsList = widget.commentList;
    _forumId = widget.forumId;
    _isAuthenticated();
    _getUserData();
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
                              if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CommentFormScreen(
                                      forumId: data.forumId,
                                      comment: data.body,
                                      commentId: data.id,
                                    ),
                                  ),
                                );
                              } else if (value == 'delete') {
                                print(
                                    'delete clickec with comment id ${data.id}');
                                deleteComment(
                                  forum: data.forumId,
                                  comment: data.id,
                                );
                              }
                            },
                            itemBuilder: (context) {
                              return [
                                PopupMenuItem(
                                  value: 'edit',
                                  child: IconWithText(
                                    Icons.edit,
                                    'Edit',
                                    color: Colors.green.shade400,
                                  ),
                                ),
                                PopupMenuItem(
                                  value: 'delete',
                                  child: IconWithText(
                                    Icons.delete,
                                    'Delete',
                                    color: Colors.red[500],
                                  ),
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
