import 'package:jin_widget_helper/jin_widget_helper.dart';

class Person {
  String name;
  String imageUrl;
  String profile;

  Person({this.name, this.imageUrl, this.profile});
}

List<Person> peoples = [
  Person(
    name: "Danich",
    profile:
        JinUtils.randomCategoryStringImage(dimension: 100, category: "people"),
    imageUrl: JinUtils.randomStringImage(200),
  ),
  Person(
    name: "Synat",
    profile:
        JinUtils.randomCategoryStringImage(dimension: 101, category: "people"),
    imageUrl: JinUtils.randomStringImage(220),
  ),
  Person(
    name: "Phearak",
    profile:
        JinUtils.randomCategoryStringImage(dimension: 102, category: "people"),
    imageUrl: JinUtils.randomStringImage(230),
  ),
  Person(
    name: "Sopheak",
    profile:
        JinUtils.randomCategoryStringImage(dimension: 103, category: "people"),
    imageUrl: JinUtils.randomStringImage(240),
  ),
  Person(
    name: "Nala",
    profile:
        JinUtils.randomCategoryStringImage(dimension: 104, category: "people"),
    imageUrl: JinUtils.randomStringImage(250),
  ),
];
