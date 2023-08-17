import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
      backgroundColor: const Color.fromARGB(255, 29, 201, 192),
    ),
  );
}

Future<List<File>> getImages() async {
  List<File> images = [];
  try {
    List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    for (XFile file in pickedFiles) {
      images.add(File(file.path));
    }
  } catch (e) {
    debugPrint(e.toString());
  }
  return images;
}
