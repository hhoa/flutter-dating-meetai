import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/res/images.dart';
import 'package:shimmer/shimmer.dart';

class LoadingImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.heightSliderImage,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            MyAssetImage.placeholder,
            fit: BoxFit.cover,
          ),
          Opacity(
            opacity: 0.4,
            child: Shimmer.fromColors(
                child: Container(
                  color: MyColor.grey,
                ),
                baseColor: MyColor.grey,
                highlightColor: MyColor.highlightGrey),
          ),
        ],
      ),
    );
  }
}
