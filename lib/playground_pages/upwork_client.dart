import 'package:flutter/material.dart';



class Profession{
  String name;
  Color color;
  Profession(this.name,this.color);

}
class MyPage2Widget extends StatelessWidget {
  final List<Profession> profession = [
    Profession("Building")
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          child: Text(
            'Choose your profession',
            style: TextStyle(color: Colors.white),
          ),
        ),
        Container(
          margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: GridView.builder(
            padding: EdgeInsets.zero,
            itemCount: ,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemBuilder: (context, index) {
              return Card()
            },
          ),
        ),
      ],
    );
  }
}
