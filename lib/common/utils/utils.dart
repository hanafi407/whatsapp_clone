import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' ;

showSnacbar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(content)));
}

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (err) {
    showSnacbar(context: context, content: err.toString());
  }

  return image;
}
