import 'package:flutter/material.dart';
import 'package:holtira_reminder/shared/shared.dart';
import 'package:holtira_reminder/ui/pages/pages.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPage(),
        debugShowCheckedModeBanner: false,
      color: mainColor,
    );
  }
}
