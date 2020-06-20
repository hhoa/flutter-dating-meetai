import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';
import 'package:flutter_dating_meetai/utils/utility.dart';

class UserInfo extends StatelessWidget {
  final String name;
  final DateTime birthday;
  final String work;
  final String education;
  final String bio;

  UserInfo({
    this.name,
    this.birthday,
    this.work,
    this.education,
    this.bio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            name,
            style: MyAssetFont.boldName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          paddingVertical(14),
          buildIconAndText(Icons.date_range, textBirthDay()),
          paddingVertical(12),
          buildIconAndText(Icons.work, work),
          paddingVertical(12),
          buildIconAndText(Icons.school, education),
          paddingVertical(14),
          buildBio(),
        ],
      ),
    );
  }

  String textBirthDay() {
    int age = DateTime.now().year - (birthday?.year ?? 1960);

    return "${birthday.toDdMmmYyyy()}, $age years old";
  }

  Widget paddingVertical(double value) {
    return SizedBox(
      height: value,
    );
  }

  Widget buildIconAndText(IconData icon, String text) {
    return Row(
      children: <Widget>[
        Icon(
          icon,
          size: 20,
          color: MyColor.redIcon,
        ),
        SizedBox(
          width: 14,
        ),
        Expanded(
            child: Text(
          text,
          style: MyAssetFont.normalDescription,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        )),
      ],
    );
  }

  Widget buildBio() {
    return Text(
      bio,
      style: MyAssetFont.normalBio,
    );
  }
}
