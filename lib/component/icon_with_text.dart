import 'package:flutter/material.dart';

class IconWithText extends StatelessWidget {
  final IconData iconData;
  final String text;
  final Color color;

  const IconWithText(this.iconData, this.text, {this.color = Colors.black});

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        new Icon(
          this.iconData,
          color: this.color,
        ),
        new Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: new Text(this.text, style: TextStyle(color: this.color)),
        )
      ],
    );
  }
}
