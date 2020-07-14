import 'dart:async';

import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';

class FlutterWebViewExample extends StatefulWidget {
  @override
  _FlutterWebViewExampleState createState() => _FlutterWebViewExampleState();
}

class _FlutterWebViewExampleState extends State<FlutterWebViewExample>
    with BasicPage {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  @override
  Widget body(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: WebView(
            initialUrl: 'https://travona.net',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
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
              print('Page started loading: $url');
            },
            onPageFinished: (String url) {
              print('Page finished loading: $url');
            },
            gestureNavigationEnabled: true,
          ),
        );
      },
    );
  }

  @override
  String appBarTitle() {
    return "Flutter Webview Example";
  }
}
