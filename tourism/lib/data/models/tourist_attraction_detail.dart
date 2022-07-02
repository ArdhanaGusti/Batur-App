class TouristAttractionDetailResult {
  TouristAttractionDetailResult({
    required this.result,
  });

  TouristAttractionDetail result;

  factory TouristAttractionDetailResult.fromJson(Map<String, dynamic> json) =>
      TouristAttractionDetailResult(
        result: TouristAttractionDetail.fromJson(json["result"]),
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
      };
}

class TouristAttractionDetail {
  TouristAttractionDetail({
    required this.formattedPhoneNumber,
    required this.geometry,
    required this.name,
    required this.openingHours,
    required this.photos,
    required this.placeId,
    required this.rating,
    required this.reviews,
    required this.url,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  String formattedPhoneNumber;
  Geometry geometry;
  String name;
  OpeningHours openingHours;
  List<Photo> photos;
  String placeId;
  double rating;
  List<Review> reviews;
  String url;
  int userRatingsTotal;
  String vicinity;

  factory TouristAttractionDetail.fromJson(Map<String, dynamic> json) =>
      TouristAttractionDetail(
        formattedPhoneNumber: json["formatted_phone_number"],
        geometry: Geometry.fromJson(json["geometry"]),
        name: json["name"],
        openingHours: OpeningHours.fromJson(json["opening_hours"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        placeId: json["place_id"],
        rating: json["rating"].toDouble(),
        reviews:
            List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
        url: json["url"],
        userRatingsTotal: json["user_ratings_total"],
        vicinity: json["vicinity"],
      );

  Map<String, dynamic> toJson() => {
        "formatted_phone_number": formattedPhoneNumber,
        "geometry": geometry.toJson(),
        "name": name,
        "opening_hours": openingHours.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "place_id": placeId,
        "rating": rating,
        "reviews": List<dynamic>.from(reviews.map((x) => x.toJson())),
        "url": url,
        "user_ratings_total": userRatingsTotal,
        "vicinity": vicinity,
      };
}

class Geometry {
  Geometry({
    required this.location,
  });

  Location location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
        location: Location.fromJson(json["location"]),
      );

  Map<String, dynamic> toJson() => {
        "location": location.toJson(),
      };
}

class Location {
  Location({
    required this.lat,
    required this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lng": lng,
      };
}

class OpeningHours {
  OpeningHours({
    required this.openNow,
    required this.periods,
    required this.weekdayText,
  });

  bool openNow;
  List<Period> periods;
  List<String> weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
        openNow: json["open_now"],
        periods:
            List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
        weekdayText: List<String>.from(json["weekday_text"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "open_now": openNow,
        "periods": List<dynamic>.from(periods.map((x) => x.toJson())),
        "weekday_text": List<dynamic>.from(weekdayText.map((x) => x)),
      };
}

class Period {
  Period({
    required this.close,
    required this.open,
  });

  Close close;
  Close open;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
        close: Close.fromJson(json["close"]),
        open: Close.fromJson(json["open"]),
      );

  Map<String, dynamic> toJson() => {
        "close": close.toJson(),
        "open": open.toJson(),
      };
}

class Close {
  Close({
    required this.day,
    required this.time,
  });

  int day;
  String time;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
        day: json["day"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "time": time,
      };
}

class Photo {
  Photo({
    required this.height,
    required this.photoReference,
    required this.width,
  });

  int height;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        height: json["height"],
        photoReference: json["photo_reference"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "height": height,
        "photo_reference": photoReference,
        "width": width,
      };
}

class Review {
  Review({
    required this.authorName,
    required this.rating,
    required this.text,
    required this.time,
  });

  String authorName;
  int rating;
  String text;
  int time;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        authorName: json["author_name"],
        rating: json["rating"],
        text: json["text"],
        time: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "author_name": authorName,
        "rating": rating,
        "text": text,
        "time": time,
      };
}
