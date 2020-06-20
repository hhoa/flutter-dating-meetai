import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/widgets/loading_image.dart';
import 'package:flutter_dating_meetai/widgets/loading_app_bar.dart';
import 'package:flutter_dating_meetai/widgets/loading_text.dart';
import 'package:shimmer/shimmer.dart';

class LoadingProfileScreen extends StatefulWidget {
  @override
  _LoadingProfileScreenState createState() => _LoadingProfileScreenState();
}

class _LoadingProfileScreenState extends State<LoadingProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        LoadingAppBar(),
        LoadingImage(),
        _buildLoadingText(),
      ],
    );
  }

  Widget _buildLoadingText() {
    return Container(
      margin: EdgeInsets.only(top: 28, left: 16, right: 16),
      child: Shimmer.fromColors(
        baseColor: MyColor.grey,
        highlightColor: MyColor.highlightGrey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LoadingText(
              height: 20,
              widthFactor: 0.5,
            ),
            paddingHeight(12),
            LoadingText(
              height: 12,
              widthFactor: 0.6,
            ),
            paddingHeight(12),
            LoadingText(
              height: 12,
              widthFactor: 0.4,
            ),
            paddingHeight(12),
            LoadingText(
              height: 12,
              widthFactor: 0.5,
            ),
            paddingHeight(16),
            LoadingText(
              height: 10,
              widthFactor: 1,
            ),
            paddingHeight(8),
            LoadingText(
              height: 10,
              widthFactor: 1,
            ),
            paddingHeight(8),
            LoadingText(
              height: 10,
              widthFactor: 1,
            ),
            paddingHeight(8),
            LoadingText(
              height: 10,
              widthFactor: 0.3,
            ),
          ],
        ),
      ),
    );
  }

  Widget paddingHeight(double value) {
    return SizedBox(
      height: value,
    );
  }
}
