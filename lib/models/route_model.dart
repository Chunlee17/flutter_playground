class RouteModel {
  List<Route> routes;
  List<Waypoint> waypoints;
  String code;
  String uuid;

  RouteModel({
    this.routes,
    this.waypoints,
    this.code,
    this.uuid,
  });

  factory RouteModel.fromJson(Map<String, dynamic> json) => RouteModel(
        routes: json["routes"] == null ? null : List<Route>.from(json["routes"].map((x) => Route.fromJson(x))),
        waypoints: json["waypoints"] == null ? null : List<Waypoint>.from(json["waypoints"].map((x) => Waypoint.fromJson(x))),
        code: json["code"] == null ? null : json["code"],
        uuid: json["uuid"] == null ? null : json["uuid"],
      );

  Map<String, dynamic> toJson() => {
        "routes": routes == null ? null : List<dynamic>.from(routes.map((x) => x.toJson())),
        "waypoints": waypoints == null ? null : List<dynamic>.from(waypoints.map((x) => x.toJson())),
        "code": code == null ? null : code,
        "uuid": uuid == null ? null : uuid,
      };
}

class Route {
  String weightName;
  List<Leg> legs;
  Geometry geometry;
  double distance;
  double duration;
  double weight;

  Route({
    this.weightName,
    this.legs,
    this.geometry,
    this.distance,
    this.duration,
    this.weight,
  });

  factory Route.fromJson(Map<String, dynamic> json) => Route(
        weightName: json["weight_name"] == null ? null : json["weight_name"],
        legs: json["legs"] == null ? null : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
        geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "weight_name": weightName == null ? null : weightName,
        "legs": legs == null ? null : List<dynamic>.from(legs.map((x) => x.toJson())),
        "geometry": geometry == null ? null : geometry.toJson(),
        "distance": distance == null ? null : distance,
        "duration": duration == null ? null : duration,
        "weight": weight == null ? null : weight,
      };
}

class Geometry {
  List<List<double>> coordinates;
  String type;

  Geometry({
    this.coordinates,
    this.type,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        coordinates: json["coordinates"] == null ? null : List<List<double>>.from(json["coordinates"].map((x) => List<double>.from(x.map((x) => x.toDouble())))),
        type: json["type"] == null ? null : json["type"],
      );

  Map<String, dynamic> toJson() => {
        "coordinates": coordinates == null ? null : List<dynamic>.from(coordinates.map((x) => List<dynamic>.from(x.map((x) => x)))),
        "type": type == null ? null : type,
      };
}

class Leg {
  String summary;
  List<dynamic> steps;
  double distance;
  double duration;
  double weight;

  Leg({
    this.summary,
    this.steps,
    this.distance,
    this.duration,
    this.weight,
  });

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
        summary: json["summary"] == null ? null : json["summary"],
        steps: json["steps"] == null ? null : List<dynamic>.from(json["steps"].map((x) => x)),
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        duration: json["duration"] == null ? null : json["duration"].toDouble(),
        weight: json["weight"] == null ? null : json["weight"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "summary": summary == null ? null : summary,
        "steps": steps == null ? null : List<dynamic>.from(steps.map((x) => x)),
        "distance": distance == null ? null : distance,
        "duration": duration == null ? null : duration,
        "weight": weight == null ? null : weight,
      };
}

class Waypoint {
  double distance;
  String name;
  List<double> location;

  Waypoint({
    this.distance,
    this.name,
    this.location,
  });

  factory Waypoint.fromJson(Map<String, dynamic> json) => Waypoint(
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : List<double>.from(json["location"].map((x) => x.toDouble())),
      );

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "name": name == null ? null : name,
        "location": location == null ? null : List<dynamic>.from(location.map((x) => x)),
      };
}
