import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/images.dart';

class MyFadeImage extends StatelessWidget {
  final String imgUrl;
  final BoxFit fit;
  final double width;
  final double height;

  MyFadeImage(this.imgUrl, {this.fit = BoxFit.cover, this.width, this.height});

  @override
  Widget build(BuildContext context) {
    return FadeInImage(
      width: width,
      height: height,
      placeholder: AssetImage(MyAssetImage.placeholder),
      image: NetworkImage(imgUrl),
      fit: fit,
    );
  }
}
