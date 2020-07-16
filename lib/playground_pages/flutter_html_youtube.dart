import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/stateful_widget_mixin.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/html_parser.dart';

class FlutterHtmlYoutubePlayer extends StatefulWidget {
  @override
  _FlutterHtmlYoutubePlayerState createState() =>
      _FlutterHtmlYoutubePlayerState();
}

class _FlutterHtmlYoutubePlayerState extends State<FlutterHtmlYoutubePlayer> {
  @override
  Widget build(BuildContext context) {
    String htmlData =
        '<iframe src="https://www.youtube.com/embed/j0-HipejG2c" width="100%" height="300" style="border:1px solid black;"></iframe>';
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Html Youtube Player"),
      ),
      body: Column(
        children: <Widget>[
          Html(
            data: htmlData,
          ),
        ],
      ),
    );
  }
}
