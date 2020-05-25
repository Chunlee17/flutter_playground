import 'package:flutter/material.dart';

class PageModel {
  final beforeCapitalLetter = RegExp(r"(?=[A-Z])");
  Widget page;
  Duration animationDuration;
  String image;
  bool shouldHaveTransition;
  PageModel({
    this.animationDuration = const Duration(milliseconds: 500),
    this.image,
    @required this.page,
    this.shouldHaveTransition = false,
  });

  @override
  String toString() {
    String title = "";
    List<String> titles = page.toStringShort().split(beforeCapitalLetter);
    titles.forEach((t) => title += "$t ");
    return title;
  }
}
