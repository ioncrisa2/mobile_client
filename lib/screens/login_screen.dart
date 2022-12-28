import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/Helper/flash_msg.dart';
import 'package:mobile_client/component/input_form_field.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _hasError = false;
  String _errorMessage = "";

  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future submitLoginForm() async {
    final res = await Provider.of<Auth>(context, listen: false).requestLogin({
      "email": _emailController.text,
      "password": _passwordController.text,
    });

    if (res['status'] == true) {
      print('login success');
      Navigator.pushNamed(context, '/home');
    } else {
      setState(() {
        _hasError = true;
        _errorMessage = res['error_message'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Screen'),
      ),
      body: Builder(
        builder: (scaffoldContext) {
          showFlashMsg(context, scaffoldContext);

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                        icon: Icon(Icons.email), labelText: "Email Anda"),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        icon: Icon(Icons.lock), labelText: "Password"),
                  ),
                  //visibility of error message
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Visibility(
                      //show text error if error is true
                      visible: _hasError,
                      //if error is true, show error message
                      child: Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  WideButton(
                    onPressed: submitLoginForm,
                    btnText: 'Login',
                    btnColor: Colors.blue,
                    btnTextColor: Colors.white,
                  ),
                  SizedBox(height: 10),
                  RichText(
                    text: TextSpan(
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      children: [
                        TextSpan(text: 'Belum punya akun? '),
                        TextSpan(
                          text: 'Daftar',
                          style: TextStyle(color: Colors.blue),
                          recognizer: TapGestureRecognizer()
                            ..onTap =
                                () => Navigator.pushNamed(context, '/register'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
