import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jin_widget_helper/jin_widget_helper.dart';
import 'package:rect_getter/rect_getter.dart';

List<String> images = [
  randomStringImage(212),
  randomStringImage(211),
  randomStringImage(210),
  randomStringImage(209),
  randomStringImage(208),
  randomStringImage(207),
  randomStringImage(206),
  randomStringImage(205),
  randomStringImage(204),
  randomStringImage(203),
  randomStringImage(202),
  randomStringImage(201),
];

class SharedElementTransition extends StatefulWidget {
  @override
  _SharedElementTransitionState createState() =>
      _SharedElementTransitionState();
}

class _SharedElementTransitionState extends State<SharedElementTransition>
    with SingleTickerProviderStateMixin {
  bool isPageViewVisible = false;
  PageController pageController = PageController();
  ScrollController scrollController = ScrollController();
  AnimationController animationController; //<-- Add AnimationController
  Animation<Rect> rectAnimation;
  OverlayEntry transitionOverlayEntry;

  List gridKeys =
      List.generate(images.length, (i) => RectGetter.createGlobalKey());
  List pageKeys =
      List.generate(images.length, (i) => RectGetter.createGlobalKey());

  int get currentIndex => pageController.page.round();

  void setPageViewVisible(bool value) {
    setState(() {
      isPageViewVisible = value;
    });
  }

  void showPageView(int index) async {
    pageController.jumpToPage(index);
    await Future.delayed(Duration(milliseconds: 100));
    startTransition(true);
    await Future.delayed(Duration(milliseconds: 400));
    setPageViewVisible(true);
  }

  void hidePageView(int index) async {
    scrollToIndex(index);
    await Future.delayed(Duration(milliseconds: 100));
    startTransition(false);
    setPageViewVisible(false);
  }

  void startTransition(bool toPageView) {
    Rect gridRect = RectGetter.getRectFromKey(gridKeys[currentIndex]);
    Rect pageRect = RectGetter.getRectFromKey(pageKeys[currentIndex]);

    rectAnimation = RectTween(
      begin: gridRect,
      end: pageRect,
    ).animate(animationController);

    Overlay.of(context).insert(transitionOverlayEntry);

    if (toPageView) {
      animationController.forward(); //<--run the animation
    } else {
      animationController.reverse();
    }
  }

  void scrollToIndex(int index) {
    //find card height
    double deviceWidth = MediaQuery.of(context).size.width;
    double cardHeight = deviceWidth / 2;
    //find row we are looking for
    int row = index ~/ 2;
    print("$index $row");
    row -= 1; // subtract 1 to have target row in the center of screen
    //calculate target offset
    double target = row * cardHeight;
    //normalize target
    target = max(
      scrollController.position.minScrollExtent,
      min(
        target,
        scrollController.position.maxScrollExtent,
      ),
    );
    //jump to target
    scrollController.jumpTo(target);
  }

  @override
  void initState() {
    transitionOverlayEntry = createOverlayEntry();
    animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed ||
          status == AnimationStatus.dismissed) {
        transitionOverlayEntry.remove(); //<-- remove Entry from the Overlay
      }
      if (status == AnimationStatus.completed) {
        setPageViewVisible(true);
      } else if (status == AnimationStatus.reverse) {
        setPageViewVisible(false);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose(); //<-- Remember to dispose the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isPageViewVisible) {
          hidePageView(currentIndex);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Shared Element Transition"),
        ),
        body: Stack(
          children: <Widget>[
            buildGridImages(),
            _buildWhiteCurtain(),
            buildPageViewImage(),
          ],
        ),
      ),
    );
  }

  Widget buildPageViewImage() {
    PageView pageView = PageView.builder(
      itemCount: images.length,
      controller: pageController,
      itemBuilder: (context, index) {
        return Center(
          child: RectGetter(
            key: pageKeys[index],
            child: Image.network(images[index]),
          ),
        );
      },
    );

    return Opacity(
      opacity: isPageViewVisible ? 1 : 0, // <--- make PageView transparent
      child: IgnorePointer(
        ignoring: !isPageViewVisible, // <--- make PageView ignore the cliks
        child: pageView,
      ),
    );
  }

  Widget buildGridImages() {
    return GridView.builder(
      gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: images.length,
      controller: scrollController,
      itemBuilder: (context, index) {
        return Card(
          child: RectGetter(
            key: gridKeys[index],
            child: InkWell(
              onTap: () => showPageView(index),
              child: Center(
                child: Image.network(images[index]),
              ),
            ),
          ),
        );
      },
    );
  }

  AnimatedBuilder _buildWhiteCurtain() {
    return AnimatedBuilder(
      //<-- rebuild on animation changes
      animation: animationController,
      builder: (context, child) {
        return animationController.isDismissed
            ? Container() //<--replace the curtain with empty container if controller is dismissed.
            : Positioned.fill(
                child: Opacity(
                  opacity: animationController.value,
                  child: Container(color: Colors.white),
                ),
              );
      },
    );
  }

  OverlayEntry createOverlayEntry() {
    return OverlayEntry(
      builder: (context) {
        return AnimatedBuilder(
          //<-- rebuild when animation changes
          animation: rectAnimation,
          builder: (context, child) {
            return Positioned(
              top: rectAnimation.value.top,
              left: rectAnimation.value.left,
              child: Image.network(
                images[currentIndex],
                height: rectAnimation.value.height,
                width: rectAnimation.value.width,
              ),
            );
          },
        );
      },
    );
  }
}
