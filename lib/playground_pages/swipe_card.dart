import 'package:flutter/material.dart';
import 'package:flutter_playground/widgets/swipe_card_child.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class SwipeCard extends StatefulWidget {
  @override
  _SwipeCardState createState() => _SwipeCardState();
}

class _SwipeCardState extends State<SwipeCard> {
  int currentIndex = 0;

  List peoples = [
    {
      "name": "Chunlee 1",
      "image": JinUtils.randomStringImage(500),
    },
    {
      "name": "Chunlee 2",
      "image": JinUtils.randomStringImage(400),
    },
    {
      "name": "Chunlee 3",
      "image": JinUtils.randomStringImage(300),
    },
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Swipe Card"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            if (peoples.isEmpty) Center(child: Text("No more people left.")),
            for (var people in peoples)
              Positioned.fill(
                top: peoples.indexOf(people) * 4.0,
                left: peoples.indexOf(people) * 4.0,
                child: SwipeCardChild(
                  people: people,
                  key: UniqueKey(),
                  onIndexChange: () {
                    setState(() {
                      peoples.insert(0, peoples.removeLast());
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
