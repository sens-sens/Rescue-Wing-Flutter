import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MapViewer extends StatefulWidget {
  const MapViewer({
    required this.url,
    super.key,
  });
  final Uri url;

  @override
  State<MapViewer> createState() => _MapViewerState();
}

class _MapViewerState extends State<MapViewer> {
  late final WebViewController controller;

  @override
  void initState() {
    controller = WebViewController()
     ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(widget.url);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: WebViewWidget(
          controller: controller),
      ),
    );
  }
}
