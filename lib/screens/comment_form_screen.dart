import 'package:flutter/material.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/screens/forum_detail_screen.dart';
import 'package:mobile_client/service/forum_service.dart';

class CommentFormScreen extends StatefulWidget {
  final int forumId;
  final String comment;
  final int commentId;

  CommentFormScreen({Key key, this.forumId, this.comment, this.commentId})
      : super(key: key);

  @override
  State<CommentFormScreen> createState() => _CommentFormScreenState();
}

class _CommentFormScreenState extends State<CommentFormScreen> {
  bool _editMode = false;
  bool _hasError = false;
  String _errorMsg = "";
  final TextEditingController _bodyCtrl = TextEditingController();

  @override
  dispose() {
    _bodyCtrl.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    if (widget.comment != null) {
      _bodyCtrl.text = widget.comment;
      _editMode = true;
    }
  }

  Future insertComment() async {
    var res;

    if (_editMode == false) {
      res = await ForumService()
          .postComment({'body': _bodyCtrl.text}, widget.forumId);
    } else if (_editMode == true) {
      res = await ForumService().updateComment(
        {'body': _bodyCtrl.text},
        widget.forumId,
        widget.commentId,
      );
    }

    print("data : $res");

    if (res['status'] == true) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ForumDetailScreen(id: widget.forumId),
        ),
      );
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
        title: Text(_editMode == false ? 'New Comments' : 'Edit Comments'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _bodyCtrl,
                maxLines: null,
                decoration: InputDecoration(
                    icon: Icon(Icons.closed_caption), labelText: "Discussion"),
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
                  btnText: _editMode == false ? 'Submit' : 'Edit',
                  btnColor: Colors.blueAccent.shade400,
                  btnTextColor: Colors.white,
                  onPressed: () => insertComment(),
                ),
                SizedBox(height: 10),
                WideButton(
                  btnText: 'Back',
                  btnColor: Colors.grey.shade400,
                  btnTextColor: Colors.black,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ForumDetailScreen(id: widget.forumId),
                      ),
                    );
                  },
                ),
              ]),
            ],
          )),
    );
  }
}
