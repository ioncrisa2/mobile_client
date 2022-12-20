import 'package:flutter/material.dart';

void showFlashMsg(context, scaffoldContext) {
  final Map args = ModalRoute.of(context).settings.arguments;

  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (args != null) {
      // ignore: deprecated_member_use
      Scaffold.of(scaffoldContext).showSnackBar(
        SnackBar(
          content: Text(args['flash_msg']),
          duration: Duration(seconds: 2),
        ),
      );
    }
  });
}
