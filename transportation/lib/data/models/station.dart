class StationResult {
  StationResult({
    required this.results,
  });

  List<Result> results;

  factory StationResult.fromJson(Map<String, dynamic> json) => StationResult(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.geometry,
    required this.name,
    required this.photos,
    required this.placeId,
    required this.rating,
    required this.userRatingsTotal,
    required this.vicinity,
  });

  Geometry geometry;
  String name;
  List<Photo>? photos;
  String placeId;
  double rating;
  int userRatingsTotal;
  String vicinity;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    name: json["name"],
    photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"],
    rating: json["rating"].toDouble(),
    userRatingsTotal: json["user_ratings_total"],
    vicinity: json["vicinity"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "name": name,
    "photos": photos == null ? null : List<dynamic>.from(photos!.map((x) => x.toJson())),
    "place_id": placeId,
    "rating": rating,
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