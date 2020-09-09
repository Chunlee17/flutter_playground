import 'package:flutter/material.dart';

class SilverAppBarWithTabBarScreen extends StatefulWidget {
  @override
  _SilverAppBarWithTabBarState createState() => _SilverAppBarWithTabBarState();
}

class _SilverAppBarWithTabBarState extends State<SilverAppBarWithTabBarScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;

  List<Widget> tabs = [
    TabViewList(title: 'Tab1'),
    TabViewList(title: 'Tab2'),
    TabViewList(title: 'Tab3'),
  ];

  @override
  void initState() {
    super.initState();
    controller = new TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        physics: BouncingScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  expandedHeight: 200.0,
                  floating: false,
                  pinned: true,
                  stretch: true,
                  stretchTriggerOffset: 25,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      title: Text("Collapsing Toolbar",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                          )),
                      background: Image.network(
                        "https://images.pexels.com/photos/396547/pexels-photo-396547.jpeg?auto=compress&cs=tinysrgb&h=350",
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
          ];
        },
        body: Container(
          child: Column(
            children: <Widget>[
              TabBar(
                controller: controller,
                labelColor: Colors.black87,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(text: "Tab 1"),
                  Tab(text: "Tab 1"),
                  Tab(text: "Tab 2"),
                ],
              ),
              Expanded(child: TabViewList()),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.animateTo(
            1,
            duration: Duration(milliseconds: 100),
            curve: Curves.bounceIn,
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

class TabViewList extends StatefulWidget {
  final String title;
  TabViewList({this.title});

  _TabViewListState createState() => _TabViewListState();
}

class _TabViewListState extends State<TabViewList> {
  ScrollController scrollController;

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    scrollController = ScrollController()
      ..addListener(() {
        if (scrollController.offset != 0.0) {
          int total = (scrollController.position.maxScrollExtent / 20).floor();
          double currentItem = scrollController.position.pixels / total;
          print(currentItem);
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        controller: scrollController,
        itemCount: 20,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            trailing: Icon(Icons.access_alarm),
            leading: Icon(Icons.accessibility_new),
            title: Text('${widget.title}'),
            subtitle: Text("hello kappa $index"),
          );
        },
      ),
    );
  }
}
