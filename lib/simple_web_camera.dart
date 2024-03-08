library simple_web_camera;

import 'package:flutter/material.dart';

import 'pages/shared.dart';

/// A simple page for taking a picture on web.
/// Returns an image as base64 encoded string.
/// In order to display the base64 encoded image you can do:
///    Image.memory(base64Decode(theReturnedBase64String).
class SimpleWebCameraPage extends StatefulWidget {
  /// AppBar Title
  final String? appBarTitle;

  /// Center Title
  final bool? centerTitle;

  const SimpleWebCameraPage({
    super.key,
    this.appBarTitle,
    this.centerTitle,
  });

  @override
  State<SimpleWebCameraPage> createState() => _SimpleWebCameraPageState();
}

class _SimpleWebCameraPageState extends State<SimpleWebCameraPage> {
  @override
  Widget build(BuildContext context) {
    return WebCameraPage(
      appBarTitle: widget.appBarTitle,
      centerTitle: widget.centerTitle,
      onPictureTaken: (String imageDataBase64Str) {
        if (mounted) {
          Navigator.pop(context, imageDataBase64Str);
        }
      },
      onCancel: () {
        if (mounted) {
          Navigator.pop(context, null);
        }
      },
    );
  }
}
