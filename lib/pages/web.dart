// ignore: avoid_web_libraries_in_flutter
import "dart:html" as html;
import "dart:ui_web" as ui;

import "package:flutter/material.dart";

class WebCameraPage extends StatelessWidget {
  final String cancelButtonText;
  final Function(String) onPictureTaken;
  final Function() onCancel;
  final String? appBarTitle;
  final bool? centerTitle;

  const WebCameraPage({
    super.key,
    this.cancelButtonText = "Cancel",
    required this.onPictureTaken,
    required this.onCancel,
    this.appBarTitle,
    this.centerTitle,
  });

  @override
  Widget build(BuildContext context) {
    String createdViewId = DateTime.now().microsecondsSinceEpoch.toString();
    final html.IFrameElement iframe = html.IFrameElement()
      ..src = "assets/packages/simple_web_camera/assets/camera.html"
      ..style.border = "none"
      ..style.width = "100%"
      ..style.height = "100%"
      ..onLoad.listen(
        (event) async {
          /// Listener on success image taken
          html.window.onMessage.listen(
            (event) {
              // Check if the data received is a string that could be a Data URL for an image
              if (event.data is String &&
                  event.data.startsWith("data:image/png;base64,")) {
                final data = event.data as String;
                final String imageDataBase64Str = data.split(",")[1];
                onPictureTaken(imageDataBase64Str);
              } else {
                onCancel();
              }
            },
          );
        },
      );

    // ignore: undefined_prefixed_name
    ui.platformViewRegistry
        .registerViewFactory(createdViewId, (int viewId) => iframe);
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle ?? "Take a picture"),
        centerTitle: centerTitle,
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.black),
        child: HtmlElementView(
          viewType: createdViewId,
        ),
      ),
    );
  }
}
