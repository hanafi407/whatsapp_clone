import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  ErrorScreen({super.key, required this.contentError});

  String contentError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(contentError),
      ),
    );
  }
}
