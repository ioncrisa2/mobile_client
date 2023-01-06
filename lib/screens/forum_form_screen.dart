import 'package:flutter/material.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/screens/forum_detail_screen.dart';
import 'package:mobile_client/screens/home_screen.dart';
import 'package:mobile_client/service/forum_service.dart';

class ForumFormScreen extends StatefulWidget {
  final int id;
  ForumFormScreen({Key key, this.id}) : super(key: key);

  @override
  State<ForumFormScreen> createState() => _ForumFormScreenState();
}

class _ForumFormScreenState extends State<ForumFormScreen> {
  bool _editMode = false;
  bool _hasError = false;
  String _errorMsg = "";
  final _titleCtrl = TextEditingController();
  final _bodyCtrl = TextEditingController();
  final _categoryCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.id != null) {
      filledForm(widget.id);
      _editMode = true;
    }
  }

  void filledForm(id) async {
    final forumData = await ForumService().detailForum(id);
    _titleCtrl.text = forumData.title;
    _bodyCtrl.text = forumData.body;
    _categoryCtrl.text = forumData.category;
  }

  void dispose() {
    _titleCtrl.dispose();
    _bodyCtrl.dispose();
    _categoryCtrl.dispose();
    super.dispose();
  }

  Future insertForum() async {
    var res;

    if (_editMode == false) {
      res = await ForumService().postForum({
        'title': _titleCtrl.text,
        'body': _bodyCtrl.text,
        'category': _categoryCtrl.text,
      });
    } else if (_editMode == true) {
      res = await ForumService().editForum({
        'title': _titleCtrl.text,
        'body': _bodyCtrl.text,
        'category': _categoryCtrl.text,
      }, widget.id);
    }

    print("data : $res");

    if (res['status'] == true) {
      if (_editMode == false) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      } else if (_editMode == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ForumDetailScreen(id: widget.id),
          ),
        );
      }
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
        title: Text(_editMode == false ? 'New Discussion' : 'Edit Duscussion'),
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
                    icon: Icon(Icons.closed_caption), labelText: "Discussion"),
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
                  btnText: _editMode == false ? 'Submit' : 'Edit',
                  btnColor: Colors.blueAccent.shade400,
                  btnTextColor: Colors.white,
                ),
                SizedBox(height: 10),
                WideButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ForumDetailScreen(id: widget.id),
                      ),
                    );
                  },
                  btnText: 'Back',
                  btnColor: Colors.grey.shade400,
                  btnTextColor: Colors.black,
                ),
              ])
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
