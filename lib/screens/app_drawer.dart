import 'package:flutter/material.dart';
import 'package:mobile_client/component/app_drawer_menu.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatefulWidget {
  AppDrawer({Key key}) : super(key: key);

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    Future submitLogout() async {
      final res =
          await Provider.of<Auth>(context, listen: false).requestLogout();
      if (res['status'] == true) {
        Navigator.pushNamed(context, '/login');
      } else {
        print('logout failed');
      }
    }

    var isLoggedIn = context.watch<Auth>().isAuthenticated;

    var _menuList = [];

    if (isLoggedIn == true) {
      final user = context.read<Auth>().user;
      _menuList = <Widget>[
        ListTile(
          title: Text('${user.username ?? 'username'}',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
          subtitle: Text('${user.email ?? 'email'}'),
        ),
        Divider(),
        AppDrawerMenu(
          route: '/home',
          title: 'Home',
          icon: Icon(Icons.home),
        ),
        AppDrawerMenu(
          route: '/profile',
          title: 'Profile',
          icon: Icon(Icons.account_box),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              tileColor: Colors.red,
              leading: Icon(Icons.logout, color: Colors.white),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                submitLogout();
                Navigator.of(context).pop();
              },
            ),
          ),
        )
      ];
    } else {
      _menuList = <Widget>[
        AppDrawerMenu(
          route: '/home',
          title: 'Home',
          icon: Icon(Icons.home),
        ),
        AppDrawerMenu(
          route: '/login',
          title: 'Login',
          icon: Icon(Icons.login),
        ),
        AppDrawerMenu(
          route: '/register',
          title: 'Register',
          icon: Icon(Icons.format_align_justify_outlined),
        ),
      ];
    }

    return Drawer(
      child: Container(
        margin: EdgeInsets.only(top: 40),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: _menuList,
        ),
      ),
    );
  }
}
