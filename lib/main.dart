import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'sign_in.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sp = await SharedPreferences.getInstance();
  bool isLogin = sp.getBool('is_login') ?? false;
  await Future.delayed(const Duration(seconds: 3));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: isLogin ? Home() : SignIn(),
    ),
  );
}
