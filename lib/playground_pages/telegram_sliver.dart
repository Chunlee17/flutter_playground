import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/diagnostics.dart';
import 'package:flutter_playground/widgets/ui_helper.dart';

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

  @override
  void initState() {
    height = maxSliverHeight;
    heightController.stream.listen((data) {
      if (data > minimumShowIconHeight && !showIcon) {
        setState(() {
          showIcon = true;
        });
      }
      if (data < minimumShowIconHeight && showIcon) {
        setState(() {
          showIcon = false;
        });
      }
    });
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
                IconButton(icon: Icon(Icons.video_call), onPressed: () {}),
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
                              CircleAvatar(child: Text("T")),
                              UIHelper.horizontalSpace(),
                              Text("Telegram Sliver"),
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
        body: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("Hello"),
              leading: CircleAvatar(
                child: Text('T'),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget sliverBottomWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(showIcon ? 32 : 0),
      child: StreamBuilder<double>(
        stream: heightController.stream,
        initialData: maxSliverHeight,
        builder: (context, snapshot) {
          return Container(
            height: showIcon ? 32 : 0,
            child: Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                Positioned(
                  bottom: -24,
                  right: 24,
                  child: CircleAvatar(
                    radius: 24,
                    child: Icon(Icons.message),
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
