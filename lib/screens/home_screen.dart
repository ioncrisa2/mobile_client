import 'package:flutter/material.dart';
import 'package:mobile_client/component/icon_with_text.dart';
import 'package:mobile_client/model/forum.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:mobile_client/service/forum_service.dart';
import 'package:provider/provider.dart';
import 'package:mobile_client/screens/forum_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<Forums> futureForums;

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
    futureForums = ForumService().getForums();
  }

  void checkIsLoggedIn() async {
    await Provider.of<Auth>(context, listen: false).requestCheckLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dicussion Forum'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => Navigator.pushNamed(context, '/home'),
          )
        ],
      ),
      body: FutureBuilder(
          future: futureForums,
          builder: (ctx, ss) {
            if (ss.hasData) {
              return ForumListWidget(forums: ss.data.forums);
            } else if (ss.hasError) {
              return Text("${ss.error}");
            }
            return Center(child: CircularProgressIndicator());
          }),
      drawer: AppDrawer(),
    );
  }
}

class ForumListWidget extends StatefulWidget {
  final forums;
  ForumListWidget({Key key, @required this.forums}) : super(key: key);

  @override
  State<ForumListWidget> createState() => _ForumListWidgetState();
}

class _ForumListWidgetState extends State<ForumListWidget> {
  List<Forum> _forumList;

  @override
  void initState() {
    super.initState();
    _forumList = widget.forums;
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _forumList.length,
      itemBuilder: (ctx, index) {
        final item = _forumList[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(
              color: Colors.grey.shade400,
            ),
          ),
          shadowColor: Colors.grey.shade50,
          child: ListTile(
            title: Text('${item.title}'),
            subtitle: IconWithText(
              Icons.list,
              '${item.category} by ${item.user.username}',
            ),
            trailing: Icon(Icons.info, color: Colors.black87),
            onTap: () {
              print('clicked ${item.id}');
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ForumDetailScreen(id: _forumList[index].id),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
