import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class TelegramSliver extends StatefulWidget {
  @override
  _TelegramSliverState createState() => _TelegramSliverState();
}

class _TelegramSliverState extends State<TelegramSliver>
    with SingleTickerProviderStateMixin {
  double maxSliverHeight = 220;
  double minimumShowIconHeight = 150;
  double height;
  double safePadding;
  StreamController<double> heightController = StreamController.broadcast();
  StreamController<bool> bgController = StreamController.broadcast();
  AnimationController controller;
  ScrollController scrollController;

  bool get showIcon => height < (maxSliverHeight + safePadding) / 2;
  Future<void> onStretching() async {
    controller.forward();
    bgController.add(true);
    return;
  }

  void onReverseStretching() {
    controller.reverse();
    bgController.add(false);
  }

  @override
  void initState() {
    height = maxSliverHeight;
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    heightController.close();
    bgController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    safePadding = MediaQuery.of(context).padding.top;
    print("Rebuild page");
    return Scaffold(
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: maxSliverHeight,
            pinned: true,
            stretch: true,
            onStretchTrigger: onStretching,
            stretchTriggerOffset: 24,
            snap: false,
            floating: false,
            bottom: sliverBottomWidget(),
            actions: <Widget>[
              IconButton(icon: Icon(Icons.call), onPressed: () {}),
              IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
            ],
            flexibleSpace: LayoutBuilder(builder: (context, constraint) {
              height = constraint.biggest.height;
              heightController.add(height);
              if (showIcon && controller.isCompleted) onReverseStretching();
              //
              return FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                stretchModes: [StretchMode.zoomBackground],
                background: ScaleTransition(
                  scale: controller,
                  alignment: Alignment(-0.8, 0.8),
                  child: Image.network("http://picsum.photos/100",
                      fit: BoxFit.cover),
                ),
                titlePadding: EdgeInsets.only(
                    left: (1 - height / (maxSliverHeight + safePadding)).abs() *
                        80),
                title: StreamBuilder<bool>(
                  initialData: false,
                  stream: bgController.stream,
                  builder: (context, snapshot) {
                    return buildTitle(snapshot.data);
                  },
                ),
              );
            }),
          ),
          SliverPadding(
            padding: EdgeInsets.only(top: 32),
            sliver: SliverGrid.count(
              crossAxisCount: 2,
              children: List.generate(
                20,
                (index) => Card(
                  child: Center(child: Text("Hello World")),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildTitle(bool isStrech) {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            AnimatedContainer(
              width: isStrech ? 0 : 40,
              height: isStrech ? 0 : 40,
              duration: Duration(milliseconds: 100),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage("http://picsum.photos/100"),
                ),
              ),
            ),
            JinWidget.horizontalSpace(),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Chunlee Thong"),
                Text(
                  "last seen recenlty",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget sliverBottomWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: StreamBuilder<double>(
        stream: heightController.stream,
        initialData: maxSliverHeight,
        builder: (context, height) {
          double opacity = height.data < 140 ? 0 : 1;
          return Container(
            height: opacity == 1 ? 24 : 0,
            color: Colors.transparent,
            child: Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  bottom: -24,
                  right: 24,
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 100),
                    opacity: opacity,
                    child: InkWell(
                      onTap: () {
                        print("Message click");
                      },
                      child: CircleAvatar(
                        radius: 24,
                        backgroundColor: Theme.of(context).accentColor,
                        child: Icon(Icons.message, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
