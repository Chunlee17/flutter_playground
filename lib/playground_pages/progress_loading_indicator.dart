import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class ProgressLoadingIndicator extends StatefulWidget {
  @override
  _ProgressLoadingIndicatorState createState() =>
      _ProgressLoadingIndicatorState();
}

class _ProgressLoadingIndicatorState extends State<ProgressLoadingIndicator> {
  final isLoading = false.obs<bool>();

  Future<bool> onProcessing() async {
    await Future.delayed(Duration(seconds: 1));
    bool random = Random().nextBool();
    if (!random)
      throw "Random false";
    else
      return random;
  }

  Future<void> showLoading(
      {ValueNotifier<bool> loading, Function function}) async {
    try {
      loading.value = true;
      await function();
      loading.value = false;
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Progress Loading Indicator"),
      ),
      body: Center(
        child: ActionButton(
          child: Text("Click me to process"),
          onPressed: () async {
            // As a function
            //showLoading(loading: isLoading, function: onProcessing);
            //As an extension
            onProcessing.indicateLoading(
                loadingValue: isLoading,
                onError: (error) {
                  JinNavigator.dialog(JinSimpleDialog(content: error));
                });
          },
          margin: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          isLoading: isLoading,
        ),
      ),
    );
  }
}

extension LoadingExtension on Function {
  Future<void> indicateLoading(
      {@required ValueNotifier<bool> loadingValue,
      Function(String) onError}) async {
    try {
      loadingValue.value = true;
      await this();
      loadingValue.value = false;
    } catch (e) {
      loadingValue.value = false;
      onError(e.toString());
    }
  }
}
