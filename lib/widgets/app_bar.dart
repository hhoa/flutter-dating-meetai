import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';
import 'package:flutter_dating_meetai/widgets/my_fade_image.dart';

class MyAppBar extends StatelessWidget {
  final String avatar;
  final String name;

  MyAppBar(this.avatar, this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.heightAppBar,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Center(
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
            Icon(
              Icons.favorite_border,
              color: MyColor.heartOutline,
            ),
          ],
        ),
      ),
    );
  }
}
