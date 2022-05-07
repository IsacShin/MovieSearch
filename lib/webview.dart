import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewWidget extends StatelessWidget {
  final String linkUrl;

  const WebViewWidget({Key? key, required this.linkUrl}): super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(),
        body: SafeArea(
          child: WebView(
            initialUrl: linkUrl,
            javascriptMode: JavascriptMode.unrestricted,
          ),
        ),
    );
  }
}