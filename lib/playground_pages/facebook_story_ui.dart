import 'package:flutter/material.dart';
import 'package:flutter_playground/models/people.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';

class FacebookStoryUI extends StatefulWidget {
  @override
  _FacebookStoryUIState createState() => _FacebookStoryUIState();
}

class _FacebookStoryUIState extends State<FacebookStoryUI>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;
  Size size;
  ScrollController scrollController;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    animation = Tween(begin: 1.0, end: 0.0).animate(controller);
    scrollController = ScrollController()
      ..addListener(() {
        controller.value = scrollController.offset / 50;
        if (scrollController.offset > 50.0) {
          if (!controller.isCompleted) controller.forward();
        } else if (scrollController.offset <= 0.0) {
          if (controller.isCompleted) controller.reverse();
        }
      });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Story UI"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Stories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ).margin(EdgeInsets.symmetric(vertical: 16, horizontal: 12)),
            Container(
              height: size.height / 4,
              child: Stack(
                children: <Widget>[
                  ListView.builder(
                    padding: EdgeInsets.all(12),
                    controller: scrollController,
                    itemCount: peoples.length + 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      if (index == 0) return myAddStoryCard();
                      final person = peoples[index - 1];
                      return Container(
                        width: size.width / 3.5,
                        padding: EdgeInsets.all(8),
                        margin: EdgeInsets.only(right: 8),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                            image: NetworkImage(person.imageUrl),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: JinWidget.radius(12),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            CircleAvatar(
                              radius: 12,
                              backgroundImage: NetworkImage(person.profile),
                            ),
                            Text(
                              person.name,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  buildAddStoryButton(),
                ],
              ),
            ),
            ListView.builder(
              itemCount: 19,
              shrinkWrap: true,
              primary: false,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  title: Text("Hello"),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget myAddStoryCard() {
    return Container(
      width: size.width / 3.5,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.grey,
        image: DecorationImage(
          image: NetworkImage(JinUtils.randomCategoryStringImage(
              dimension: 300, category: "man")),
          fit: BoxFit.cover,
        ),
        borderRadius: JinWidget.radius(12),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              "Add to story",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildAddStoryButton() {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Align(
        alignment: Alignment(-1.0, -(animation.value)),
        child: Transform.translate(
          offset: Offset(20 * animation.value, 20 * animation.value),
          child: Container(
            width: 64 - (animation.value * 32),
            height: 32 + (16 * (1 - animation.value)),
            padding: EdgeInsets.all(8 * (1 - animation.value)),
            alignment: Alignment.centerRight,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(
                right: Radius.circular(32),
                left: Radius.circular(32 * (animation.value)),
              ),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: <Widget>[
                CircleAvatar(
                  radius: 16,
                  backgroundImage: NetworkImage(
                    JinUtils.randomCategoryStringImage(
                        dimension: 500, category: "man"),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      width: 16 + (animation.value * 48),
                      height: 16 + (animation.value * 48),
                      child: FittedBox(child: Icon(Icons.add)),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ).opacity(1 - animation.value),
                Align(
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.add,
                    color: Colors.blue,
                  ).opacity(animation.value),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
