import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/container_shadow.dart';
import 'package:flutter_playground/playground_pages/draggable_scrollable_sheet.dart';
import 'package:flutter_playground/playground_pages/firebase_face_detection.dart';
import 'package:flutter_playground/playground_pages/interval_animation.dart';
import 'package:flutter_playground/playground_pages/lerp_animation.dart';
import 'package:flutter_playground/playground_pages/local_auth.dart';
import 'package:flutter_playground/playground_pages/look_rotation.dart';
import 'package:flutter_playground/playground_pages/scaling_page.dart';
import 'package:flutter_playground/playground_pages/sliver_persistent_header.dart';
import 'package:flutter_playground/playground_pages/state_rebuilder_demo.dart';
import 'package:flutter_playground/playground_pages/streambuilder.dart';

class PageModel {
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
    return page.toStringShort();
  }
}

//pages
final List<PageModel> pages = [
  PageModel(page: StreamBuilderPlayground()),
  PageModel(page: ScalingPage("https://picsum.photos/300"), shouldHaveTransition: true, image: "https://picsum.photos/300"),
  PageModel(page: IntervalAnimationPlayground()),
  PageModel(page: FirebaseFaceDetectionDemo()),
  PageModel(page: SliverPersistentHeaderDemo()),
  PageModel(page: LookRotation()),
  PageModel(page: LocalAuthenthicationDemo()),
  PageModel(page: ContainerShadowDemo()),
  PageModel(page: StateRebuilderDemo()),
  PageModel(page: LerpAnimationDemo()),
  PageModel(page: DraggableSrollableSheetDemo()),
];
