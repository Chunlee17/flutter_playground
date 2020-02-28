import 'package:flutter/material.dart';
import 'package:flutter_playground/models/page_model.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Page selector"),
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          final page = pages[index];
          return Card(
            child: ListTile(
              leading: page.image == null
                  ? CircleAvatar(child: Icon(Icons.desktop_windows))
                  : Hero(
                      tag: "Image",
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(page.image),
                      ),
                    ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 20,
              ),
              title: Text(page.toString()),
              onTap: () {
                if (page.shouldHaveTransition) {
                  Navigator.of(context).push(
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) => page.page,
                      transitionDuration: Duration(milliseconds: index == 1 ? 300 : 500),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var offset = Tween<double>(begin: 0.0, end: 1.0);
                        var offsetAnimaition = offset.animate(animation);
                        return ScaleTransition(
                          child: child,
                          scale: offsetAnimaition,
                        );
                      },
                    ),
                  );
                } else {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => page.page));
                }
              },
            ),
          );
        },
      ),
    );
  }
}
