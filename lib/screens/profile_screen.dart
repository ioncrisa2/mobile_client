import 'package:flutter/material.dart';
import 'package:mobile_client/Helper/flash_msg.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void checkIsLoggedIn() async {
    await Provider.of<Auth>(context, listen: false).requestCheckLogin();
  }

  @override
  void initState() {
    super.initState();
    checkIsLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    final user = context.read<Auth>().user;
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen ${user.username}'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => {Navigator.pushNamed(context, '/profile_edit')},
              child: Icon(Icons.edit),
            ),
          ),
        ],
      ),
      body: Builder(
        builder: (scaffoldContext) {
          showFlashMsg(context, scaffoldContext);
          return ListView(
            children: <Widget>[
              Container(
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.blueAccent.shade400],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    stops: [0.5, 0.9],
                  ),
                ),
                child: completeNameWidget(user.detail.namaLengkap),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    sidedWidget('Bergabung Pada', user.createdAt),
                    sidedWidget('Username', user.username),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    detailWidget('Email', user.email),
                    Divider(),
                    detailWidget('Tanggal Lahir', user.detail.tanggalLahir),
                    Divider(),
                    detailWidget('Tempat Lahir', user.detail.tempatLahir),
                    Divider(),
                    detailWidget('Jenis Kelamin', user.detail.jenisKelamin),
                    Divider(),
                    detailWidget('Alamat', user.detail.alamat),
                  ],
                ),
              )
            ],
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }

  Expanded sidedWidget(String text, dynamic data) {
    return Expanded(
      child: Container(
        color: Colors.blueAccent.shade400,
        child: ListTile(
          title: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          subtitle: Text(
            data,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              color: Colors.white70,
            ),
          ),
        ),
      ),
    );
  }

  ListTile detailWidget(String text, dynamic data) {
    return ListTile(
      title: Text(
        text,
        style: TextStyle(
          color: Colors.blueAccent.shade400,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        data ?? 'n/a',
        style: TextStyle(
          fontSize: 15,
        ),
      ),
    );
  }

  Column completeNameWidget(String user) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              user,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        )
      ],
    );
  }
}
