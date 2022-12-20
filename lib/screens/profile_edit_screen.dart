import 'package:flutter/material.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

class ProfileEditScreen extends StatefulWidget {
  ProfileEditScreen({Key key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
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
        title: Text('Edit Profile ${user.username}'),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => print("save edited profile"),
              child: Icon(Icons.save),
            ),
          ),
        ],
      ),
    );
  }
}
