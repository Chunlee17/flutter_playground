import 'package:flutter/material.dart';
import 'package:flutter_playground/playground_pages/api_consumer.dart';
import 'package:flutter_playground/playground_pages/audio_player_demo.dart';
import 'package:flutter_playground/playground_pages/bloc_with_get_It.dart';
import 'package:flutter_playground/playground_pages/container_shadow.dart';
import 'package:flutter_playground/playground_pages/draggable_scrollable_sheet.dart';
import 'package:flutter_playground/playground_pages/firebase_face_detection.dart';
import 'package:flutter_playground/playground_pages/flutter_provider.dart';
import 'package:flutter_playground/playground_pages/flutter_stateful_widget.dart';
import 'package:flutter_playground/playground_pages/google_map_polyline.dart';
import 'package:flutter_playground/playground_pages/half_circle_clipper.dart';
import 'package:flutter_playground/playground_pages/hive_database.dart';
import 'package:flutter_playground/playground_pages/interval_animation.dart';
import 'package:flutter_playground/playground_pages/lerp_animation.dart';
import 'package:flutter_playground/playground_pages/local_auth.dart';
import 'package:flutter_playground/playground_pages/look_rotation.dart';
import 'package:flutter_playground/playground_pages/new_localization.dart';
import 'package:flutter_playground/playground_pages/page_view_enlarge.dart';
import 'package:flutter_playground/playground_pages/real_bloc_pattern.dart';
import 'package:flutter_playground/playground_pages/scaling_page.dart';
import 'package:flutter_playground/playground_pages/sliver_persistent_header.dart';
import 'package:flutter_playground/playground_pages/sound_recorder_demo.dart';
import 'package:flutter_playground/playground_pages/state_rebuilder_demo.dart';
import 'package:flutter_playground/playground_pages/streambuilder.dart';
import 'package:flutter_playground/playground_pages/telegram_sliver.dart';

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

//pages
final List<PageModel> pages = [
  PageModel(page: StreamBuilderPlayground()),
  PageModel(page: ScalingPage("https://picsum.photos/300"), shouldHaveTransition: true, image: "https://picsum.photos/300"),
  PageModel(page: IntervalAnimation()),
  PageModel(page: FirebaseFaceDetectionDemo()),
  PageModel(page: SliverPersistentHeaderDemo()),
  PageModel(page: LookRotation()),
  PageModel(page: LocalAuthenthicationDemo()),
  PageModel(page: ContainerShadowDemo()),
  PageModel(page: StateRebuilderDemo()),
  PageModel(page: RealBlocPattern()),
  PageModel(page: LerpAnimationDemo()),
  PageModel(page: DraggableSrollableSheetDemo()),
  PageModel(page: GoogleMapPolyline()),
  PageModel(page: AudioPlayerDemo()),
  PageModel(page: BlocWithGetIt()),
  PageModel(page: PageViewEnlarge()),
  PageModel(page: HalfCircleClipper()),
  PageModel(page: NewLocalization()),
  PageModel(page: SoundRecorderDemo()),
  PageModel(page: FlutterProvider()),
  PageModel(page: FlutterStatefulWidget()),
  PageModel(page: TelegramSliver()),
  PageModel(page: HiveDatabase()),
  PageModel(page: ApiConsumer()),
];
