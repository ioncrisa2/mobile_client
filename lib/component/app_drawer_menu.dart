import 'package:flutter/material.dart';

class AppDrawerMenu extends StatelessWidget {
  final String route;
  final String title;
  final Icon icon;
  const AppDrawerMenu({Key key, this.route, this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: icon,
      minLeadingWidth: 0,
      title: Text(title),
      onTap: () {
        Navigator.pushNamed(context, route);
      },
    );
  }
}
