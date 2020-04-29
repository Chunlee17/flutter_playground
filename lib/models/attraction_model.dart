class AttractionModel {
    int code;
    String message;
    List<AttractionData> data;
    Pagination pagination;
    Error error;

    AttractionModel({
        this.code,
        this.message,
        this.data,
        this.pagination,
        this.error,
    });

    factory AttractionModel.fromJson(Map<String, dynamic> json) => AttractionModel(
        code: json["code"] == null ? null : json["code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<AttractionData>.from(json["data"].map((x) => AttractionData.fromJson(x))),
        pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
        error: json["error"] == null ? null : Error.fromJson(json["error"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code == null ? null : code,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "pagination": pagination == null ? null : pagination.toJson(),
        "error": error == null ? null : error.toJson(),
    };
}

class AttractionData {
    String id;
    List<String> thumbnails;
    String name;
    AttractionLocation location;
    Merchant merchant;
    String shortDescription;
    List<String> holidays;
    List<OpeningDaysHour> openingDaysHours;
    List<Skus> skus;
    double overallRating;

    AttractionData({
        this.id,
        this.thumbnails,
        this.name,
        this.location,
        this.merchant,
        this.shortDescription,
        this.holidays,
        this.openingDaysHours,
        this.skus,
        this.overallRating,
    });

    factory AttractionData.fromJson(Map<String, dynamic> json) => AttractionData(
        id: json["_id"] == null ? null : json["_id"],
        thumbnails: json["thumbnails"] == null ? null : List<String>.from(json["thumbnails"].map((x) => x)),
        name: json["name"] == null ? null : json["name"],
        location: json["location"] == null ? null : AttractionLocation.fromJson(json["location"]),
        merchant: json["merchant"] == null ? null : Merchant.fromJson(json["merchant"]),
        shortDescription: json["short_description"] == null ? null : json["short_description"],
        holidays: json["holidays"] == null ? null : List<String>.from(json["holidays"].map((x) => x)),
        openingDaysHours: json["opening_days_hours"] == null ? null : List<OpeningDaysHour>.from(json["opening_days_hours"].map((x) => OpeningDaysHour.fromJson(x))),
        skus: json["skus"] == null ? null : List<Skus>.from(json["skus"].map((x) => Skus.fromJson(x))),
        overallRating: json["overall_rating"] == null ? null : json["overall_rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "thumbnails": thumbnails == null ? null : List<dynamic>.from(thumbnails.map((x) => x)),
        "name": name == null ? null : name,
        "location": location == null ? null : location.toJson(),
        "merchant": merchant == null ? null : merchant.toJson(),
        "short_description": shortDescription == null ? null : shortDescription,
        "holidays": holidays == null ? null : List<dynamic>.from(holidays.map((x) => x)),
        "opening_days_hours": openingDaysHours == null ? null : List<dynamic>.from(openingDaysHours.map((x) => x.toJson())),
        "skus": skus == null ? null : List<dynamic>.from(skus.map((x) => x.toJson())),
        "overall_rating": overallRating == null ? null : overallRating,
    };
}

class AttractionLocation {
    String id;
    double lat;
    double long;

    AttractionLocation({
        this.id,
        this.lat,
        this.long,
    });

    factory AttractionLocation.fromJson(Map<String, dynamic> json) => AttractionLocation(
        id: json["_id"] == null ? null : json["_id"],
        lat: json["lat"] == null ? null : json["lat"].toDouble(),
        long: json["long"] == null ? null : json["long"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "lat": lat == null ? null : lat,
        "long": long == null ? null : long,
    };
}

class Merchant {
    String id;
    String name;

    Merchant({
        this.id,
        this.name,
    });

    factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
        id: json["_id"] == null ? null : json["_id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "name": name == null ? null : name,
    };
}

class OpeningDaysHour {
    int day;
    String status;
    Hour hour;

    OpeningDaysHour({
        this.day,
        this.status,
        this.hour,
    });

    factory OpeningDaysHour.fromJson(Map<String, dynamic> json) => OpeningDaysHour(
        day: json["day"] == null ? null : json["day"],
        status: json["status"] == null ? null : json["status"],
        hour: json["hour"] == null ? null : Hour.fromJson(json["hour"]),
    );

    Map<String, dynamic> toJson() => {
        "day": day == null ? null : day,
        "status": status == null ? null : status,
        "hour": hour == null ? null : hour.toJson(),
    };
}

class Hour {
    String from;
    String to;

    Hour({
        this.from,
        this.to,
    });

    factory Hour.fromJson(Map<String, dynamic> json) => Hour(
        from: json["from"] == null ? null : json["from"],
        to: json["to"] == null ? null : json["to"],
    );

    Map<String, dynamic> toJson() => {
        "from": from == null ? null : from,
        "to": to == null ? null : to,
    };
}

class Skus {
    String id;
    Price localPrice;
    Price foreignPrice;
    String status;
    OldPrice oldPrice;

    Skus({
        this.id,
        this.localPrice,
        this.foreignPrice,
        this.status,
        this.oldPrice,
    });

    factory Skus.fromJson(Map<String, dynamic> json) => Skus(
        id: json["_id"] == null ? null : json["_id"],
        localPrice: json["local_price"] == null ? null : Price.fromJson(json["local_price"]),
        foreignPrice: json["foreign_price"] == null ? null : Price.fromJson(json["foreign_price"]),
        status: json["status"] == null ? null : json["status"],
        oldPrice: json["old_price"] == null ? null : OldPrice.fromJson(json["old_price"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id == null ? null : id,
        "local_price": localPrice == null ? null : localPrice.toJson(),
        "foreign_price": foreignPrice == null ? null : foreignPrice.toJson(),
        "status": status == null ? null : status,
        "old_price": oldPrice == null ? null : oldPrice.toJson(),
    };
}

class Price {
    double kid;
    int adult;

    Price({
        this.kid,
        this.adult,
    });

    factory Price.fromJson(Map<String, dynamic> json) => Price(
        kid: json["kid"] == null ? null : json["kid"].toDouble(),
        adult: json["adult"] == null ? null : json["adult"],
    );

    Map<String, dynamic> toJson() => {
        "kid": kid == null ? null : kid,
        "adult": adult == null ? null : adult,
    };
}

class OldPrice {
    LocalPrice localPrice;
    ForeignPrice foreignPrice;

    OldPrice({
        this.localPrice,
        this.foreignPrice,
    });

    factory OldPrice.fromJson(Map<String, dynamic> json) => OldPrice(
        localPrice: json["local_price"] == null ? null : LocalPrice.fromJson(json["local_price"]),
        foreignPrice: json["foreign_price"] == null ? null : ForeignPrice.fromJson(json["foreign_price"]),
    );

    Map<String, dynamic> toJson() => {
        "local_price": localPrice == null ? null : localPrice.toJson(),
        "foreign_price": foreignPrice == null ? null : foreignPrice.toJson(),
    };
}

class ForeignPrice {
    double kid;
    double adult;

    ForeignPrice({
        this.kid,
        this.adult,
    });

    factory ForeignPrice.fromJson(Map<String, dynamic> json) => ForeignPrice(
        kid: json["kid"] == null ? null : json["kid"].toDouble(),
        adult: json["adult"] == null ? null : json["adult"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "kid": kid == null ? null : kid,
        "adult": adult == null ? null : adult,
    };
}

class LocalPrice {
    int kid;
    int adult;

    LocalPrice({
        this.kid,
        this.adult,
    });

    factory LocalPrice.fromJson(Map<String, dynamic> json) => LocalPrice(
        kid: json["kid"] == null ? null : json["kid"],
        adult: json["adult"] == null ? null : json["adult"],
    );

    Map<String, dynamic> toJson() => {
        "kid": kid == null ? null : kid,
        "adult": adult == null ? null : adult,
    };
}

class Error {
    dynamic message;

    Error({
        this.message,
    });

    factory Error.fromJson(Map<String, dynamic> json) => Error(
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}

class Pagination {
    int page;
    int count;
    int totalItems;

    Pagination({
        this.page,
        this.count,
        this.totalItems,
    });

    factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        page: json["page"] == null ? null : json["page"],
        count: json["count"] == null ? null : json["count"],
        totalItems: json["total_items"] == null ? null : json["total_items"],
    );

    Map<String, dynamic> toJson() => {
        "page": page == null ? null : page,
        "count": count == null ? null : count,
        "total_items": totalItems == null ? null : totalItems,
    };
}