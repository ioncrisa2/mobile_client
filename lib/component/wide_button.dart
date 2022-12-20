import 'package:flutter/material.dart';

class WideButton extends StatelessWidget {
  final Function onPressed;
  final Color btnColor;
  final Color btnTextColor;
  final String btnText;

  WideButton({
    Key key,
    @required this.onPressed,
    this.btnColor,
    this.btnTextColor,
    this.btnText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      // ignore: deprecated_member_use
      child: RaisedButton(
        onPressed: () {
          onPressed();
        },
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: btnColor,
        textColor: btnTextColor,
        child: Text(btnText),
      ),
    );
  }
}
