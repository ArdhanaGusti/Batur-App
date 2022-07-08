class StationDetailResult {
  StationDetailResult({
    required this.result,
  });

  Result result;

  factory StationDetailResult.fromJson(Map<String, dynamic> json) => StationDetailResult(
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "result": result.toJson(),
  };
}

class Result {
  Result({
    required this.geometry,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.rating,
    required this.reviews,
    required this.url,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  Geometry geometry;
  String name;
  List<Photo> photos;
  String placeId;
  double rating;
  List<Review> reviews;
  String url;
  int userRatingsTotal;
  String vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    name: json["name"],
    photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    rating: json["rating"].toDouble(),
    reviews: List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    url: json["url"],
    userRatingsTotal: json["user_ratings_total"],
    vicinity: json["vicinity"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "name": name,
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
    required this.language,
    required this.rating,
    required this.relativeTimeDescription,
    required this.text,
  });

  String language;
  int rating;
  String relativeTimeDescription;
  String text;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    language: json["language"],
    rating: json["rating"],
    relativeTimeDescription: json["relative_time_description"],
    text: json["text"],
  );

  Map<String, dynamic> toJson() => {
    "language": language,
    "rating": rating,
    "relative_time_description": relativeTimeDescription,
    "text": text,
  };
}
