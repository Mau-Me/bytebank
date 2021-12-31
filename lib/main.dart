import 'package:bytebank/screens/dashboard.dart';
import 'package:bytebank/theme/style.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const BytebankApp());
}

class BytebankApp extends StatelessWidget {
  const BytebankApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Dashboard(),
      debugShowCheckedModeBanner: false,
      theme: style(),
    );
  }
}
