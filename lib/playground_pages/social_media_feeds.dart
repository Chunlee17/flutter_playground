import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:flutter_playground/playground_pages/flutter_custom_route.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class SocialMediaFeeds extends StatefulWidget {
  @override
  _SocialMediaFeedsState createState() => _SocialMediaFeedsState();
}

class _SocialMediaFeedsState extends State<SocialMediaFeeds> {
  void showCommentBottomSheet() async {
    // showModalBottomSheet(
    //   context: context,
    //   isDismissible: true,
    //   shape: JinWidget.roundRectTop(32),
    //   isScrollControlled: true,
    //   builder: (context) => CommentSection(),
    // );
    Navigator.push(context, SimpleDialogRoute(CommentSection()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Latest blogs", style: Theme.of(context).textTheme.headline6)
                .marginValue(all: 16),
            SpaceY(),
            Expanded(
              child: ListView.builder(
                itemCount: 10,
                padding: EdgeInsets.symmetric(horizontal: 12),
                itemBuilder: (context, index) {
                  return buildFeedCard();
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text("Messages"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            title: Text("Profile"),
          ),
        ],
      ),
    );
  }

  Widget buildFeedCard() {
    return Card(
      elevation: 1,
      color: JinColorUtils.fromRGB(248, 248, 248),
      child: Column(
        children: <Widget>[
          MiniListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(JinUtils.randomStringImage()),
            ),
            title: Text("Chunlee Thong"),
            subtitle: Text("4 mins ago"),
            trailing: SmallIconButton(
              icon: Icon(Icons.more_horiz),
              onTap: () {},
              margin: EdgeInsets.zero,
            ),
          ),
          Text(
            "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum",
          ).paddingValue(horizontal: 16),
          SpaceY(16),
          Divider(height: 0),
          Row(
            children: <Widget>[
              SmallIconButton(
                icon: Row(
                  children: <Widget>[
                    Icon(Icons.favorite),
                    SpaceX(),
                    Text("25 likes"),
                  ],
                ),
                onTap: () {},
              ),
              Spacer(),
              SmallIconButton(
                icon: Row(
                  children: <Widget>[
                    Icon(Icons.comment),
                    SpaceX(),
                    Text("13 comments"),
                  ],
                ),
                onTap: showCommentBottomSheet,
              ),
            ],
          )
        ],
      ),
    );
  }
}

class CommentSection extends StatefulWidget {
  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection>
    with SingleTickerProviderStateMixin {
  bool isListViewScrollable = true;
  AnimationController controller;
  var animation;

  void onDragEnd(DragEndDetails details) {
    if (controller.isAnimating ||
        controller.status == AnimationStatus.completed) return;

    final double flingVelocity = details.velocity.pixelsPerSecond.dx / 700;

    print("Fling velocity: $flingVelocity");
    if (flingVelocity < 0.0)
      //reverse
      controller.fling(velocity: -1);
    else if (flingVelocity > 0)
      //forward
      controller.fling(velocity: 1);
    else
      controller.fling(velocity: controller.value < 0.5 ? -1.0 : 1.0);
  }

  onDrag(DragUpdateDetails details) {
    controller.value += details.primaryDelta / 700;
    print(controller.value);
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 400));
    controller.addListener(() => setState(() {}));
    animation = Tween(begin: 0.0, end: 400.0)
        .animate(CurvedAnimation(curve: Curves.linear, parent: controller));
    super.initState();
  }

  @override
  void dispose() {
    print("Dispose bottomsheet");
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Transform.translate(
          offset: Offset(0, animation.value),
          child: GestureDetector(
            onVerticalDragUpdate: onDrag,
            onVerticalDragEnd: onDragEnd,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              height: MediaQuery.of(context).size.height - 64,
              child: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.favorite, color: primaryColor),
                      SpaceX(),
                      Text("83 likes"),
                      Spacer(),
                      Icon(Icons.thumb_up)
                    ],
                  ).paddingValue(all: 12),
                  Divider(height: 0),
                  Expanded(
                    child: ListView.builder(
                      itemCount: 10,
                      primary: false,
                      physics: NeverScrollableScrollPhysics(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                      itemBuilder: (context, index) {
                        return CommentCard();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CommentCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(JinUtils.randomStringImage(100)),
          ),
          SpaceX(),
          Flexible(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: JinColorUtils.fromRGB(232, 233, 222),
                    borderRadius: JinWidget.radius(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Chunlee Thong",
                        style: Theme.of(context).textTheme.button,
                      ),
                      SpaceY(4),
                      Text(
                        "If you use this site regularly and would like to help keep the site on the Internet, please consider donating a small sum to help pay for the hosting and bandwidth bill. There is no minimum donation, any sum is appreciated",
                      ),
                    ],
                  ),
                ),
                SpaceY(),
                Row(
                  children: <Widget>[
                    Text("19m"),
                    SpaceX(16),
                    Text("Like", style: Theme.of(context).textTheme.button),
                    SpaceX(16),
                    Text("Reply", style: Theme.of(context).textTheme.button),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FacebookCommentScrollPhysic extends ScrollPhysics {
  const FacebookCommentScrollPhysic({ScrollPhysics parent})
      : super(parent: parent);

  @override
  FacebookCommentScrollPhysic applyTo(ScrollPhysics ancestor) {
    return FacebookCommentScrollPhysic(parent: buildParent(ancestor));
  }

  @override
  Simulation createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    return super.createBallisticSimulation(position, velocity);
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    return super.applyPhysicsToUserOffset(position, offset);
  }

  @override
  bool shouldAcceptUserOffset(ScrollMetrics position) {
    return true;
  }

  @override
  bool get allowImplicitScrolling => true;
}
