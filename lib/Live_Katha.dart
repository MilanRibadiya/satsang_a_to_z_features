import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LiveKatha extends StatefulWidget {
  @override
  _LiveKathaState createState() => _LiveKathaState();
}

class _LiveKathaState extends State<LiveKatha> {
  Future<void> __launchBrowser(String _url) async {
    if (await canLaunch(_url)) {
      await launch(
        _url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'header_key': 'header_value'},
      );
    } else {
      debugPrint('Could not launch $_url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      onProgress: (progress) {
        CircularProgressIndicator();
        debugPrint(progress.toString());
      },
      initialUrl: "https://www.youtube.com/embed/live_stream?channel=UCnsiyoETbqJnOde5yG-ZWxQ",
      javascriptMode: JavascriptMode.unrestricted,
      userAgent:
          "Moilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/37.0.2049.0 Safari/537.36",
      navigationDelegate: (NavigationRequest request) {
        if (request.url.startsWith("https://www.youtube.com/watch?") ||
            request.url.startsWith("https://www.youtube.com/channel")) {
          __launchBrowser('https://youtube.com/c/Gunatit1008byKalakunjMandirSurat');
          return NavigationDecision.prevent;
        } else if (request.url.startsWith('https://www.youtube.com/') ||
            request.url.startsWith('https://support.google.com/')) {
          print('blocking navigation to $request}');
          return NavigationDecision.prevent;
        }
        print('allowing navigation to $request');
        return NavigationDecision.navigate;
      },
    );
  }

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
