import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:shimmer/shimmer.dart';

class LoadingAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Constants.heightAppBar,
      margin: EdgeInsets.symmetric(horizontal: 16),
      child: Shimmer.fromColors(
        baseColor: MyColor.grey,
        highlightColor: MyColor.highlightGrey,
        child: Row(
          children: <Widget>[
            _buildCircle(),
            paddingHorizontal(12),
            _buildName(context),
          ],
        ),
      ),
    );
  }

  Widget paddingHorizontal(double value) {
    return SizedBox(
      width: value,
    );
  }

  Widget _buildCircle() {
    return Container(
      height: Constants.heightAvatar,
      width: Constants.heightAvatar,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
    );
  }

  Widget _buildName(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      margin: EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.red,
      ),
    );
  }
}
