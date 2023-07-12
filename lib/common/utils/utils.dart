import 'package:flutter/material.dart';

showSnacbar({required BuildContext context,required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}
