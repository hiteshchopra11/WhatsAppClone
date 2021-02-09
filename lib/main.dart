import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'home_page.dart';

void main() {
  return runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff075E54),
        accentColor: Color(0xff25d366),
      ),
      home: WhatsappHome(),
    );
  }
}
