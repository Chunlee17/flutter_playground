import 'package:flutter/material.dart';

class MyPage2Widget extends StatelessWidget {
  final double spacing = 2.0;
  final double radius = 4.0;
  final TextStyle kWhiteText =
      TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w500);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF9E9E9E),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              alignment: Alignment.center,
              child: Text(
                'Choose your profession',
                style: kWhiteText,
              ),
            ),
            Container(
              padding: EdgeInsets.all(spacing),
              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(radius),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      buildItem(
                        title: "Plumbing",
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(radius),
                        ),
                        color: Color(0xFF00A2E8),
                        onTap: () {},
                      ),
                      SizedBox(width: spacing),
                      buildItem(
                        title: "Gardening",
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(radius),
                        ),
                        color: Color(0xFFB5E61D),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    children: [
                      buildItem(
                        title: "Electrical",
                        color: Color(0xFFB5E61D),
                        onTap: () {},
                      ),
                      SizedBox(width: spacing),
                      buildItem(
                        title: "Handyperson",
                        color: Color(0xFFC8BFE7),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    children: [
                      buildItem(
                        title: "I.T. Help",
                        color: Color(0xFFFF7F27),
                        onTap: () {},
                      ),
                      SizedBox(width: spacing),
                      buildItem(
                        title: "building",
                        color: Color(0xFFB97A57),
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),
                  Row(
                    children: [
                      buildItem(
                        title: "Cleaning",
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(radius),
                        ),
                        color: Color(0xFFEFE5B1),
                        onTap: () {},
                      ),
                      SizedBox(width: spacing),
                      buildItem(
                        title: "Automobile",
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(radius),
                        ),
                        color: Color(0xFF00C599),
                        onTap: () {},
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildItem({
    String title,
    Color color,
    BorderRadius borderRadius,
    Function onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap ?? () {},
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          decoration: BoxDecoration(
            color: color,
            borderRadius: borderRadius ?? BorderRadius.circular(0),
          ),
        ),
      ),
    );
  }
}
