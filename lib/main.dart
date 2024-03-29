import 'package:flutter/material.dart';
import 'package:flutter_login_demo/services/authentication.dart';
import 'package:flutter_login_demo/pages/root_page.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: "Synarcs Login App",
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(primarySwatch: Colors.green),
        home: new RootPage(auth: new Auth()));
  }
}
