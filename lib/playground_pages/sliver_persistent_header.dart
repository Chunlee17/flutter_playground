import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SliverPersistentHeaderDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            title: Text("Slivers Persistent header"),
            expandedHeight: 250,
            pinned: true,
            floating: true,
            snap: true,
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: Delegate("Section 1"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                15,
                (index) => ListTile(
                  title: Text("hello section 1"),
                ),
              ).toList(),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            floating: false,
            delegate: Delegate("Section 2"),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              List.generate(
                15,
                (index) => ListTile(
                  title: Text("hello section 2"),
                ),
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class Delegate extends SliverPersistentHeaderDelegate {
  final String title;
  Delegate(this.title);
  @override
  Widget build(
          BuildContext context, double shrinkOffset, bool overlapsContent) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 0),
        child: Container(
          height: maxExtent,
          color: Colors.yellow,
          alignment: Alignment.center,
          child: Text(title),
        ),
      );

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
