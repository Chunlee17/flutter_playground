//pages

import 'package:flutter/cupertino.dart';
import 'package:flutter_playground/models/page_model.dart';
import 'package:flutter_playground/playground_pages/3d_drawer.dart';
import 'package:flutter_playground/playground_pages/api_consumer_with_cache.dart';
import 'package:flutter_playground/playground_pages/api_consumer_with_stream.dart';
import 'package:flutter_playground/playground_pages/audio_service_example.dart';
import 'package:flutter_playground/playground_pages/custom_expansion_tile.dart';
import 'package:flutter_playground/playground_pages/flutter_curve_animation.dart';
import 'package:flutter_playground/playground_pages/flutter_custom_route.dart';
import 'package:flutter_playground/playground_pages/flutter_html_youtube.dart';
import 'package:flutter_playground/playground_pages/flutter_over_flow_box.dart';
import 'package:flutter_playground/playground_pages/flutter_tween_sequence_animation.dart';
import 'package:flutter_playground/playground_pages/flutter_value_notififer.dart';
import 'package:flutter_playground/playground_pages/flutter_webview.dart';
import 'package:flutter_playground/playground_pages/loading_button_experiment.dart';
import 'package:flutter_playground/playground_pages/mobx_state_management.dart';
import 'package:flutter_playground/playground_pages/momentum_state_management.dart';
import 'package:flutter_playground/playground_pages/pagination.dart';
import 'package:flutter_playground/playground_pages/social_media_feeds.dart';
import 'package:flutter_playground/playground_pages/stack_architecture_example.dart';
import 'package:flutter_playground/playground_pages/stream_with_get_It.dart';
import 'package:flutter_playground/playground_pages/clipper_playground.dart';
import 'package:flutter_playground/playground_pages/container_shadow.dart';
import 'package:flutter_playground/playground_pages/custom_dialog_example.dart';
import 'package:flutter_playground/playground_pages/dart_inheritance.dart';
import 'package:flutter_playground/playground_pages/draggable_scrollable_sheet.dart';
import 'package:flutter_playground/playground_pages/facebook_story_ui.dart';
import 'package:flutter_playground/playground_pages/flip_page_transition.dart';
import 'package:flutter_playground/playground_pages/flutter_animation_package.dart';
import 'package:flutter_playground/playground_pages/flutter_clipper.dart';
import 'package:flutter_playground/playground_pages/flutter_inherited_widget.dart';
import 'package:flutter_playground/playground_pages/flutter_mixin_stateful_widget_example.dart';
import 'package:flutter_playground/playground_pages/flutter_navigation_rails.dart';
import 'package:flutter_playground/playground_pages/provider_state_management.dart';
import 'package:flutter_playground/playground_pages/flutter_stateful_widget.dart';
import 'package:flutter_playground/playground_pages/get_package_state_management.dart';
import 'package:flutter_playground/playground_pages/google_map_inside_scrollview.dart';
import 'package:flutter_playground/playground_pages/google_map_polyline.dart';
import 'package:flutter_playground/playground_pages/hive_database.dart';
import 'package:flutter_playground/playground_pages/inherited_provider.dart';
import 'package:flutter_playground/playground_pages/interval_animation.dart';
import 'package:flutter_playground/playground_pages/lerp_animation.dart';
import 'package:flutter_playground/playground_pages/local_auth.dart';
import 'package:flutter_playground/playground_pages/look_rotation.dart';
import 'package:flutter_playground/playground_pages/easy_localization_package.dart';
import 'package:flutter_playground/playground_pages/node_api_boilerplate_testing.dart';
import 'package:flutter_playground/playground_pages/page_view_enlarge.dart';
import 'package:flutter_playground/playground_pages/progress_loading_indicator.dart';
import 'package:flutter_playground/playground_pages/provider_with_stream.dart';
import 'package:flutter_playground/playground_pages/proxy_provider_demo.dart';
import 'package:flutter_playground/playground_pages/bloc_state_management.dart';
import 'package:flutter_playground/playground_pages/scaling_page.dart';
import 'package:flutter_playground/playground_pages/shared_element_transition.dart';
import 'package:flutter_playground/playground_pages/sliver_persistent_header.dart';
import 'package:flutter_playground/playground_pages/sliver_with_tabbar.dart';
import 'package:flutter_playground/playground_pages/sqflite_todo.dart';
import 'package:flutter_playground/playground_pages/streambuilder.dart';
import 'package:flutter_playground/playground_pages/swipe_action.dart';
import 'package:flutter_playground/playground_pages/swipe_card.dart';
import 'package:flutter_playground/playground_pages/telegram_sliver.dart';
import 'package:flutter_playground/playground_pages/test_internet.dart';
import 'package:flutter_playground/playground_pages/video_player_demo.dart';

final List<PageModel> pages = [
  PageModel(
    page: StreamBuilderPlayground(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: ScalingPage("https://picsum.photos/300"),
    shouldHaveTransition: true,
    image: "https://picsum.photos/300",
    pageType: PageType.Widget,
  ),
  PageModel(
    page: IntervalAnimation(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SliverPersistentHeaderDemo(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: LookRotation(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: LocalAuthenthicationDemo(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: ContainerShadowDemo(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: AudioServiceExample(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: CustomExpansionTile(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: BlocStateManagement(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: LerpAnimationDemo(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: DraggableSrollableSheetDemo(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: GoogleMapPolyline(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: StreamWithGetIt(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: PageViewEnlarge(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterClipper(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: EasyLocalizationPackageDemo(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: ProviderStateManagement(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: FlutterStatefulWidget(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: TelegramSliver(),
    pageType: PageType.Widget,
  ),
  //PageModel(page: HiveDatabase(), pageType: PageType.Widget),
  PageModel(
    page: ApiConsumerWithCache(),
    pageType: PageType.Utility,
  ),
  PageModel(
    page: StackArchitectureHome(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: FlutterWebViewExample(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: FlutterTweenSequenceAnimationExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterValueNotifierExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterCurveAnimationExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterCustomRouteExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: LoadingButtonExperiment(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: ApiConsumerWithStream(),
    pageType: PageType.Utility,
  ),
  PageModel(
    page: FlutterInheritedWidget(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterNavigationRails(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: GetPackageStateManagement(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: MobXStateManagementExample(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: MomentumStateManagementExample(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: FlipPageTransition(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterAnimationPackage(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: ClipperPlayground(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: ThreeDDrawer(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SharedElementTransition(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SwipeCard(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: ProxyProviderDemo(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: SilverAppBarWithTabBarScreen(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: GoogleMapInsideScrollView(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FacebookStoryUI(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SqfLiteTodoApp(),
    pageType: PageType.Database,
  ),
  PageModel(
    page: InheritedProviderDemo(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: TestInternetConnection(),
    pageType: PageType.Utility,
  ),
  PageModel(
    page: VideoPlayerDemo(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: PaginationExample(),
    pageType: PageType.Package,
  ),
  PageModel(
    page: ProviderWithStream(),
    pageType: PageType.StateManagement,
  ),
  PageModel(
    page: NodeApiBoilerPlateTesting(),
    pageType: PageType.Utility,
  ),
  PageModel(
    page: FlutterStatefulMixinExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterHtmlYoutubePlayer(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SwipeAction(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: DartInheritance(),
    pageType: PageType.CodePlayground,
  ),
  PageModel(
    page: CustomDialogExample(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: ProgressLoadingIndicator(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: SocialMediaFeeds(),
    pageType: PageType.Widget,
  ),
  PageModel(
    page: FlutterOverflowBox(),
    pageType: PageType.Widget,
  ),
];
