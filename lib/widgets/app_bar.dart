import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';
import 'package:flutter_dating_meetai/widgets/my_fade_image.dart';
import 'package:flutter_dating_meetai/widgets/pulse_heart.dart';

class MyAppBar extends StatelessWidget {
  final String avatar;
  final String name;
  final bool hasShadow;

  MyAppBar(this.avatar, this.name, {this.hasShadow = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.heightAppBar,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: hasShadow
            ? <BoxShadow>[
                BoxShadow(
                    color: Color(0x5e000000),
                    offset: Offset(0, 2),
                    blurRadius: 2,
                    spreadRadius: 0)
              ]
            : [],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(Constants.heightAvatar / 2),
              child: MyFadeImage(
                avatar,
                width: Constants.heightAvatar,
                height: Constants.heightAvatar,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Expanded(
              child: Text(
                name,
                style: MyAssetFont.boldAvatar,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            PulseHeart(),
          ],
        ),
      ),
    );
  }
}
