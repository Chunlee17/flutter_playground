import 'package:flutter/material.dart';
import 'package:flutter_playground/models/page_model.dart';
import 'package:flutter_playground/pages/page_list.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class HomePageDrawer extends StatelessWidget {
  final List<PageType> types = PageType.values;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("Flutter Playground"),
            accountEmail: Text("chunlee.thong@gmail.com"),
          ),
          for (var type in types)
            ExpansionTile(
              title: Text(type.toStringShort()),
              leading: Icon(Icons.view_comfy),
              children: <Widget>[
                ...pages
                    .where((PageModel pageModel) {
                      return pageModel.pageType == type;
                    })
                    .map(buildPageItem)
                    .toList(),
              ],
            ),
        ],
      ),
    );
  }

  Widget buildPageItem(PageModel pageModel) {
    return MiniListTile(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      leading: Icon(Icons.bookmark, color: Colors.grey),
      title: Text(
        pageModel.toString(),
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      onTap: () => JinNavigator.push(pageModel.page),
    );
  }
}

extension GetName on PageType {
  String toStringShort() {
    return this.toString().split(".").last;
  }
}
