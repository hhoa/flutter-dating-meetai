import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';

class LoadingText extends StatelessWidget {
  final double widthFactor;
  final double height;

  LoadingText({@required this.widthFactor, this.height = 8});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: widthFactor,
      child: Container(
          height: height,
          decoration: BoxDecoration(
              color: MyColor.grey, borderRadius: BorderRadius.circular(4.5))),
    );
  }
}
