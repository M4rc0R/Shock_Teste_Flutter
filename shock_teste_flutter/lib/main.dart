import 'package:flutter/material.dart';
import 'Tela_Login.dart';

void main() => runApp(MyApp());

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shock Teste',
      theme: ThemeData(primarySwatch: Colors.cyan),
      home: LoginPage(),
    );
  }
}
