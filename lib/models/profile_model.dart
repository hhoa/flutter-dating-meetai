import 'dart:convert';

import 'package:flutter_dating_meetai/models/profile.dart';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  ProfileModel({
    this.profile,
  });

  Profile profile;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    profile: json["profile"] == null ? null : Profile.fromJson(json["profile"]),
  );

  Map<String, dynamic> toJson() => {
    "profile": profile == null ? null : profile.toJson(),
  };
}