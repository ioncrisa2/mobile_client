import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/component/input_form_field.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/auth_service.dart';
// import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _namaLengkapController = TextEditingController();
  final _usernameController = TextEditingController();
  final _nimController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  //error handle from api call
  bool _hasError = false;
  String _errorMessage = "";

  @override
  void dispose() {
    _namaLengkapController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  Future submitRegisterForm() async {
    final res = await Auth().requestRegister({
      "nama_lengkap": _namaLengkapController.text,
      "username": _usernameController.text,
      "nim": _nimController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "confirm_password": _confirmPasswordController.text,
    });
    if (res['status'] == true) {
      //redirect to login screen
      Navigator.pushNamed(context, '/login', arguments: {
        'flash_msg': 'Berhasil Daftar, silahkan login untuk melanjutkan',
      });
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
        title: Text('Register Screen'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: <Widget>[
              InputFormField(
                controller: _namaLengkapController,
                label: 'Nama Lengkap',
                hint: 'Masukkan nama lengkap',
                icon: Icon(Icons.person),
              ),
              SizedBox(height: 10),
              InputFormField(
                  controller: _usernameController,
                  label: 'Username',
                  hint: 'Masukkan username',
                  icon: Icon(Icons.account_box)),
              SizedBox(height: 10),
              InputFormField(
                controller: _nimController,
                label: 'NIM',
                hint: 'Masukkan NIM',
                icon: Icon(Icons.confirmation_number),
              ),
              SizedBox(height: 10),
              InputFormField(
                controller: _emailController,
                label: 'Email',
                hint: 'Masukkan email',
                icon: Icon(Icons.email),
              ),
              SizedBox(height: 10),
              InputFormField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Masukkan password',
                obscureText: true,
                icon: Icon(Icons.lock),
              ),
              SizedBox(height: 10),
              InputFormField(
                controller: _confirmPasswordController,
                label: 'Konfirmasi Password',
                hint: 'Masukkan konfirmasi password',
                obscureText: true,
                icon: Icon(Icons.lock),
              ),

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
              // ignore: deprecated_member_use
              WideButton(
                onPressed: submitRegisterForm,
                btnText: 'Register',
                btnColor: Colors.blue,
                btnTextColor: Colors.white,
              ),
              Divider(height: 30, color: Colors.black),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'Sudah punya akun? '),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.pushNamed(context, '/login');
                        },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      drawer: AppDrawer(),
    );
  }
}
