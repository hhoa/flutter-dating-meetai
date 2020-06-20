import 'package:flutter_dating_meetai/utils/utility.dart';

class Moment {
  Moment({
    this.location,
    this.latLong,
    int date,
    this.images,
  }) {
    this.date = date.toDateTime();
  }

  String location;
  String latLong;
  DateTime date;
  List<String> images;

  factory Moment.fromJson(Map<String, dynamic> json) => Moment(
    location: Utils.parse<String>(json["location"]),
    latLong: Utils.parse<String>(json["latlong"]),
    date: Utils.parse<int>(json["date"]),
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "location": location,
    "latlong": latLong,
    "date": date,
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
  };
}
