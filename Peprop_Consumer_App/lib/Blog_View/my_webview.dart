import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../Utils/AppUtils.dart';

class MyWebView extends StatefulWidget {

  String selectedUrl;

  MyWebView({Key? key, required this.selectedUrl}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<MyWebView> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  bool loading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppUtils.webAppBar(context, widget.selectedUrl),
      body: SafeArea(
        child: Stack(
          children: [
            Center(child: AppUtils.progressBar(loading)),
            WebView(
              initialUrl: widget.selectedUrl.toString(),
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
              onProgress: (int progress) {
                print('WebView is loading (progress : $progress%)');
              },
              navigationDelegate: (NavigationRequest request) {
                if (request.url.startsWith('https://www.youtube.com/')) {
                  print('blocking navigation to $request}');
                  return NavigationDecision.prevent;
                }
                print('allowing navigation to $request');
                return NavigationDecision.navigate;
              },
              onPageStarted: (String url) {
                setState(() {
                  loading=true;
                });
              },
              onPageFinished: (String url) {
                setState(() {
                  loading=false;
                });
              },
              gestureNavigationEnabled: true,
              backgroundColor: const Color(0x00000000),
            ),
          ],
        ),
      ),
    );
  }
}
