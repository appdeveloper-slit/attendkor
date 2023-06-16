import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'biometric.dart';
import 'home.dart';
import 'sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final LocalAuthentication auth = LocalAuthentication();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin = sp.getBool('is_login') ?? false;
  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? Home(b: true) : SignIn(),
    ),
  );
}
enum _SupportState {
  unknown,
  supported,
  unsupported,
}