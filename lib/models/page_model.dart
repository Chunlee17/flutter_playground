import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/container_shadow.dart';
import 'package:flutter_playground/playground_pages/draggable_scrollable_sheet.dart';
import 'package:flutter_playground/playground_pages/firebase_face_detection.dart';
import 'package:flutter_playground/playground_pages/flutter_audio_player_demo.dart';
import 'package:flutter_playground/playground_pages/flutter_bloc_get_it.dart';
import 'package:flutter_playground/playground_pages/flutter_pageview_enlarge.dart';
import 'package:flutter_playground/playground_pages/flutter_provider.dart';
import 'package:flutter_playground/playground_pages/flutter_sound_recorder.dart';
import 'package:flutter_playground/playground_pages/flutter_stateful.dart';
import 'package:flutter_playground/playground_pages/google_map_polyline.dart';
import 'package:flutter_playground/playground_pages/half_circle_clipper.dart';
import 'package:flutter_playground/playground_pages/interval_animation.dart';
import 'package:flutter_playground/playground_pages/lerp_animation.dart';
import 'package:flutter_playground/playground_pages/local_auth.dart';
import 'package:flutter_playground/playground_pages/look_rotation.dart';
import 'package:flutter_playground/playground_pages/new_localization.dart';
import 'package:flutter_playground/playground_pages/real_bloc_pattern.dart';
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
  PageModel(
      page: ScalingPage("https://picsum.photos/300"),
      shouldHaveTransition: true,
      image: "https://picsum.photos/300"),
  PageModel(page: IntervalAnimationPlayground()),
  PageModel(page: FirebaseFaceDetectionDemo()),
  PageModel(page: SliverPersistentHeaderDemo()),
  PageModel(page: LookRotation()),
  PageModel(page: LocalAuthenthicationDemo()),
  PageModel(page: ContainerShadowDemo()),
  PageModel(page: StateRebuilderDemo()),
  PageModel(page: RealBlocPattern()),
  PageModel(page: LerpAnimationDemo()),
  PageModel(page: DraggableSrollableSheetDemo()),
  PageModel(page: GoogleMapPolyLineDemo()),
  PageModel(page: FlutterAudioPlayerDemo()),
  PageModel(page: FlutterBlocWithGetIt()),
  PageModel(page: FlutterPageViewEnlarge()),
  PageModel(page: HalfCircleClipper()),
  PageModel(page: NewLocalization()),
  PageModel(page: FlutterSoundRecoder()),
  PageModel(page: FlutterProvider()),
  PageModel(page: FlutterStatefulWidget()),
];
