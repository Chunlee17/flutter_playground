import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class TelegramSliver extends StatefulWidget {
  @override
  _TelegramSliverState createState() => _TelegramSliverState();
}

class _TelegramSliverState extends State<TelegramSliver>
    with SingleTickerProviderStateMixin {
  double maxSliverHeight = 200;
  double minimumShowIconHeight = 140;
  double height;
  StreamController<double> heightController = StreamController.broadcast();
  bool showIcon = true;
  ScrollController scrollController;

  @override
  void initState() {
    height = maxSliverHeight;
    scrollController = ScrollController()..addListener(() {});
    super.initState();
  }

  @override
  void dispose() {
    heightController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var safePadding = MediaQuery.of(context).padding.top;
    print("Rebuild page");
    return Scaffold(
      body: NestedScrollView(
        controller: scrollController,
        headerSliverBuilder: (context, scrolled) => [
          SliverSafeArea(
            top: false,
            sliver: SliverAppBar(
              expandedHeight: maxSliverHeight,
              pinned: true,
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
                return FlexibleSpaceBar(
                  collapseMode: CollapseMode.pin,
                  stretchModes: [StretchMode.fadeTitle],
                  titlePadding: EdgeInsets.only(
                      left:
                          (1 - height / (maxSliverHeight + safePadding)).abs() *
                              80),
                  title: Stack(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                child: Text("C"),
                                backgroundColor: Colors.white,
                              ),
                              UIHelper.horizontalSpace(),
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text("Chunlee Thong"),
                                  Text(
                                    "last seen recenlty",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
          )
        ],
        body: ListView.separated(
          itemCount: 15,
          separatorBuilder: (context, index) => Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("Hello"),
              leading: CircleAvatar(child: Text('T')),
              onTap: () {},
            );
          },
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
                        child: Icon(Icons.message),
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
