import 'package:flutter_dating_meetai/models/moment.dart';
import 'package:flutter_dating_meetai/utils/utility.dart';

class Profile {
  Profile({
    this.username,
    this.name,
    birthday,
    workDate,
    this.work,
    this.education,
    this.hobbies,
    this.songs,
    this.images,
    this.bio,
    this.moment,
  }) {
    this.birthdate = birthday.toDateTime();
    this.workDate = workDate.toDateTime();
  }

  String username;
  String name;
  DateTime birthdate;
  DateTime workDate;
  String work;
  String education;
  List<String> hobbies;
  List<String> songs;
  List<String> images;
  String bio;
  List<Moment> moment;

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
    username: Utils.parse<String>(json["username"]),
    name: Utils.parse<String>(json["name"]),
    birthday: Utils.parse<int>(json["birthdate"]),
    workDate: Utils.parse<int>(json["work_date"]),
    work: Utils.parse<String>(json["work"]),
    education: Utils.parse<String>(json["education"]),
    hobbies: json["hobbies"] == null ? [] : List<String>.from(json["hobbies"].map((x) => x)),
    songs: json["songs"] == null ? [] : List<String>.from(json["songs"].map((x) => x)),
    images: json["images"] == null ? [] : List<String>.from(json["images"].map((x) => x)),
    bio: Utils.parse<String>(json["bio"]),
    moment: json["moment"] == null ? null : List<Moment>.from(json["moment"].map((x) => Moment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "name": name,
    "birthdate": birthdate,
    "work_date": workDate,
    "work": work,
    "education": education,
    "hobbies": hobbies == null ? null : List<dynamic>.from(hobbies.map((x) => x)),
    "songs": songs == null ? null : List<dynamic>.from(songs.map((x) => x)),
    "images": images == null ? null : List<dynamic>.from(images.map((x) => x)),
    "bio": bio,
    "moment": moment == null ? null : List<dynamic>.from(moment.map((x) => x.toJson())),
  };
}