import 'package:flutter/material.dart';

abstract class BaseState<T extends StatefulWidget> extends State<T> {
  Size screenSize;
  Size designScreenSize;
  EdgeInsets safeAreaSize;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenSize = MediaQuery.of(context).size;
    designScreenSize = getDesignSize() ?? Size(375.0, 812.0);
    safeAreaSize = MediaQuery.of(context).padding;
  }

  Size getDesignSize() {
    return null;
  }

  double scaleHeight(double height) {
    double screenHeight = screenSize.height;
    return screenHeight * height / designScreenSize.height;
  }

  double scaleWidth(double width) {
    double screenWidth = screenSize.width;
    return screenWidth * width / designScreenSize.width;
  }
}