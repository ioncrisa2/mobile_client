import 'package:flutter/material.dart';
import 'package:mobile_client/screens/home_screen.dart';
import 'package:mobile_client/screens/login_screen.dart';
import 'package:mobile_client/screens/profile_edit_screen.dart';
import 'package:mobile_client/screens/profile_screen.dart';
import 'package:mobile_client/screens/register_screen.dart';
import 'package:mobile_client/service/auth_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Auth(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
        //named route
        routes: {
          '/home': (context) => HomeScreen(),
          '/register': (context) => RegisterScreen(),
          '/login': (context) => LoginScreen(),
          '/profile': (context) => ProfileScreen(),
          '/profile_edit': (context) => ProfileEditScreen()
        },
      ),
    ),
  );
}
