import 'package:flutter/material.dart';

class WebCameraPage extends StatelessWidget {
  final Function(String) onPictureTaken;
  final Function() onCancel;
  final String? appBarTitle;
  final bool? centerTitle;

  const WebCameraPage({
    super.key,
    required this.onPictureTaken,
    required this.onCancel,
    this.appBarTitle,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    throw "Platform not supported -> expected web";
  }
}
