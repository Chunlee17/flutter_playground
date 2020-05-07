import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FlutterNavigationRails extends StatefulWidget {
  @override
  _FlutterNavigationRailsState createState() => _FlutterNavigationRailsState();
}

class _FlutterNavigationRailsState extends State<FlutterNavigationRails> {
  int _selectedIndex = 0;
  bool _isExtend = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Navigation Rail"),
      ),
      body: Row(
        children: <Widget>[
          buildNavigationRail(),
          VerticalDivider(thickness: 1, width: 1),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() => _isExtend = false);
            },
            child: Center(child: Text("Current index: $_selectedIndex")),
          ).expanded,
        ],
      ),
    );
  }

  Widget buildNavigationRail() {
    return InkWell(
      onTap: () {
        setState(() => _isExtend = true);
      },
      child: NavigationRail(
        extended: _isExtend,
        selectedIndex: _selectedIndex,
        groupAlignment: 1,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: [
          NavigationRailDestination(
            icon: Icon(Icons.add_alert),
            label: Text("Alert"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.mail),
            label: Text("Mail"),
          ),
          NavigationRailDestination(
            icon: Icon(Icons.tablet_mac),
            label: Text("Tablet"),
          ),
        ],
      ),
    );
  }
}
