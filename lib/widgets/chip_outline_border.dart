import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';

class ChipOutlineBorder extends StatelessWidget {
  final double height;
  final IconData icon;
  final String text;

  ChipOutlineBorder({
    @required this.icon,
    @required this.text,
    this.height = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.white, width: 1)),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(
            width: 4,
          ),
          Text(
            text,
            style: MyAssetFont.boldChip,
          ),
        ],
      ),
    );
  }
}
