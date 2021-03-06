import 'package:flutter/material.dart';
import 'package:flutter_playground/utils/app_utils.dart';

class PageModel {
  Widget page;
  Duration animationDuration;
  String image;
  bool shouldHaveTransition;
  PageType pageType;
  PageModel({
    this.animationDuration = const Duration(milliseconds: 500),
    this.image,
    @required this.page,
    this.pageType,
    this.shouldHaveTransition = false,
  });

  @override
  String toString() {
    String title = "";
    List<String> titles = page.runtimeType.toString().split(beforeCapitalLetter);
    titles.forEach((t) => title += "$t ");
    return title;
  }
}

enum PageType {
  Widget,
  Animation,
  CodePlayground,
  StateManagement,
  Database,
  Utility,
  Package,
}
