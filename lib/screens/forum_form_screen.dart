import 'package:flutter/material.dart';
import 'package:mobile_client/component/input_form_field.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/service/forum_service.dart';

class ForumFormScreen extends StatefulWidget {
  ForumFormScreen({Key key}) : super(key: key);

  @override
  State<ForumFormScreen> createState() => _ForumFormScreenState();
}

class _ForumFormScreenState extends State<ForumFormScreen> {
  bool _hasError = false;
  String _errorMsg = "";
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();

  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    _categoryCtrl.dispose();
    super.dispose();
  }

  Future insertForum() async {
    final submit = {
      'title': _titleCtrl.text,
      'body': _bodyCtrl.text,
      'category': _categoryCtrl.text,
    };
    final res = await ForumService().postForum(submit);

    print("data : $res");

    if (res['status'] == true) {
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        _hasError = true;
        _errorMsg = res['error_message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('New Discussion'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _titleCtrl,
                  decoration: InputDecoration(
                      icon: Icon(Icons.title), labelText: "Discussion Title"),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _bodyCtrl,
                  maxLines: null,
                  decoration: InputDecoration(
                      icon: Icon(Icons.closed_caption),
                      labelText: "Discussion"),
                ),
                SizedBox(height: 20),
                TextField(
                  controller: _categoryCtrl,
                  decoration: InputDecoration(
                      icon: Icon(Icons.category),
                      labelText: "Discussion Category"),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Visibility(
                    visible: _hasError,
                    child: Text(_errorMsg),
                  ),
                ),
                SizedBox(height: 20),
                Column(children: [
                  WideButton(
                    onPressed: () => insertForum(),
                    btnText: 'Submit',
                    btnColor: Colors.blueAccent.shade400,
                    btnTextColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  WideButton(
                    onPressed: () => Navigator.pushNamed(context, '/home'),
                    btnText: 'Back',
                    btnColor: Colors.grey.shade400,
                    btnTextColor: Colors.black,
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}
