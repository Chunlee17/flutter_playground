import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_playground/bloc_provider_get_controller/stack_architecture/simple_view_model.dart';
import 'package:stacked/stacked.dart';

class StackArchitectureHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Using the reactive constructor gives you the traditional viewmodel
    // binding which will excute the builder again when notifyListeners is called.
    return ViewModelBuilder<SimpleViewModel>.reactive(
      viewModelBuilder: () => SimpleViewModel(),
      onModelReady: (model) => model.initialise(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: Text("Stack Architecture Example"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            model.updateTitle();
          },
          child: Icon(Icons.update),
        ),
        body: Center(
          child: Text(model.title),
        ),
      ),
    );
  }
}
