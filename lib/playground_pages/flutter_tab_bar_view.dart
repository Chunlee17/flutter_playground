import 'package:flutter/material.dart';
import 'package:flutter_playground/constant/app_constant.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FlutterTabBarView extends StatefulWidget {
  @override
  _FlutterTabBarViewState createState() => _FlutterTabBarViewState();
}

class _FlutterTabBarViewState extends State<FlutterTabBarView>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    tabController = TabController(vsync: this, length: 3);
    super.initState();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toStringShort()),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(32.0),
            child: TabBar(
              controller: tabController,
              indicator: ShapeDecoration(
                color: primaryColor,
                shape: StadiumBorder(),
              ),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              tabs: [
                Tab(
                  child: Row(
                    children: [
                      Icon(Icons.add),
                      SpaceX(),
                      Text("Nice"),
                    ],
                  ),
                ),
                Tab(text: "Dog"),
                Tab(text: "Hamster"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                TabBody(count: 10),
                TabBody(count: 6),
                TabBody(count: 2),
              ],
              controller: tabController,
            ),
          )
        ],
      ),
    );
  }
}

class TabBody extends StatefulWidget {
  final int count;

  const TabBody({Key key, this.count}) : super(key: key);
  @override
  _TabBodyState createState() => _TabBodyState();
}

class _TabBodyState extends State<TabBody> {
  Future<bool> future;
  Future<bool> waitingForValue() async {
    print("Wating for value");
    await Future.delayed(Duration(seconds: 2));
    return true;
  }

  @override
  void initState() {
    future = waitingForValue();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureHandler<bool>(
      future: future,
      ready: (snapshot) {
        return ListView.builder(
          itemCount: widget.count,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text("Hello data"),
            );
          },
        );
      },
    );
  }
}
