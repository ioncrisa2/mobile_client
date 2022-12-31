import 'package:flutter/material.dart';
import 'package:mobile_client/component/app_drawer_menu.dart';
import 'package:mobile_client/screens/login_screen.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

// import 'login_screen.dart';

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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScreen(),
          ),
        );
      } else {
        print('logout failed');
      }
    }

    var isLoggedIn = context.watch<Auth>().isAuthenticated;

    var _menuList = [];

    if (isLoggedIn == true) {
      _menuList = <Widget>[
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
        AppDrawerMenu(
          route: '/forum_form',
          title: 'New Discussion',
          icon: Icon(Icons.format_list_bulleted_outlined),
        ),
        AppDrawerMenu(
          route: '/jobinfo',
          title: 'Job Info',
          icon: Icon(Icons.work),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: ListTile(
              tileColor: Colors.red,
              leading: Icon(Icons.logout, color: Colors.white),
              minLeadingWidth: 0,
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
