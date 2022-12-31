import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_client/component/input_form_field.dart';
import 'package:mobile_client/component/wide_button.dart';
import 'package:mobile_client/screens/app_drawer.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({Key key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _namaLengkapController = TextEditingController();
  TextEditingController _nimController = TextEditingController();
  TextEditingController _tanggalLahirController = TextEditingController();
  TextEditingController _tempatLahirController = TextEditingController();
  TextEditingController _jenisKelaminController = TextEditingController();
  TextEditingController _alamatController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  List _jenisKelamin = ['Laki-laki', 'Perempuan'];
  String _jenisKelaminVal = 'Laki-laki';

  //error handle from api call
  bool _hasError = false;
  String _errorMessage = "";

  @override
  void dispose() {
    _emailController.dispose(); /** done */
    _passwordController.dispose(); /** done */
    _confirmPasswordController.dispose(); /** done */
    _usernameController.dispose(); /** done */
    _namaLengkapController.dispose(); /** done */
    _nimController.dispose(); /** done */
    _tanggalLahirController.dispose(); /** done */
    _tempatLahirController.dispose(); /** done */
    _jenisKelaminController.dispose(); /** done */
    _alamatController.dispose(); /** done */
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _tanggalLahirController.text = "";
  }

  Future submitRegisterForm() async {
    final res = await Auth().requestRegister({
      "nama_lengkap": _namaLengkapController.text,
      "nim": _nimController.text,
      "jenis_kelamin": _jenisKelaminController.text,
      "tanggal_lahir": _tanggalLahirController.text,
      "tempat_lahir": _tempatLahirController.text,
      "alamat": _alamatController.text,
      "username": _usernameController.text,
      "email": _emailController.text,
      "password": _passwordController.text,
      "confirm_password": _confirmPasswordController.text,
      "role_id": 2
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
              SizedBox(height: 10),
              TextField(
                controller: _namaLengkapController,
                decoration: InputDecoration(
                    icon: Icon(Icons.person), labelText: "Nama Lengkap"),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.number,
                maxLength: 7,
                controller: _nimController,
                decoration: InputDecoration(
                    icon: Icon(Icons.list_alt), labelText: "Nim Anda"),
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tanggalLahirController,
                decoration: InputDecoration(
                  icon: Icon(Icons.calendar_today),
                  labelText: "Masukkan Tanggal Lahir",
                ),
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1950),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    String formattedDate =
                        new DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      _tanggalLahirController.text = formattedDate;
                    });
                  } else {}
                },
              ),
              SizedBox(height: 10),
              TextField(
                controller: _tempatLahirController,
                decoration: InputDecoration(
                    icon: Icon(Icons.list_alt), labelText: "Tempat Lahir Anda"),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Jenis Kelamin"),
                  SizedBox(
                    width: 200,
                    child: DropdownButton(
                      hint: Text("Pilih Jenis Kelamin Anda"),
                      value: _jenisKelaminVal,
                      items: _jenisKelamin.map((value) {
                        return DropdownMenuItem(
                          child: Text(value),
                          value: value,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _jenisKelaminVal = value;
                          _jenisKelaminController.text = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              TextField(
                controller: _alamatController,
                maxLines: null,
                decoration: InputDecoration(
                    icon: Icon(Icons.location_city), labelText: "Alamat Anda"),
              ),
              SizedBox(height: 10),
              TextField(
                maxLength: 16,
                controller: _usernameController,
                decoration: InputDecoration(
                    icon: Icon(Icons.people_alt), labelText: "Username Anda"),
              ),
              SizedBox(height: 10),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: InputDecoration(
                    icon: Icon(Icons.email), labelText: "Email Anda"),
              ),
              SizedBox(height: 10),
              TextField(
                maxLength: 16,
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: "Password Anda"),
              ),
              SizedBox(height: 10),
              TextField(
                maxLength: 16,
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                    icon: Icon(Icons.lock), labelText: "Confirm Password Anda"),
              ),
              SizedBox(height: 10),
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
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  children: [
                    TextSpan(text: 'Sudah punya akun? '),
                    TextSpan(
                      text: 'Login',
                      style: TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Navigator.pushNamed(context, '/login'),
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
