import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/utils/screen_utils.dart';
import 'package:flutter_dating_meetai/widgets/my_fade_image.dart';
import 'package:flutter_dating_meetai/utils/utility.dart';

class ListHorizontalImages extends StatefulWidget {
  final List<String> listUrlImgs;

  ListHorizontalImages(this.listUrlImgs);

  @override
  _ListHorizontalImagesState createState() => _ListHorizontalImagesState();
}

class _ListHorizontalImagesState extends BaseState<ListHorizontalImages> {
  PageController _pageController;

  StreamController<double> _streamOffsetController = StreamController();

  Stream<double> get offsetStream => _streamOffsetController.stream;

  int get listLength => widget.listUrlImgs.length;

  int currentPage = 0;
  int nextPage = 0;
  double lastOffset = 0;
  bool isSwipeRight = true;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(initialPage: 0);

    // add listener after first frame rendered
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_pageController.hasClients) {
        _pageController.position.addListener(handleScroll);
      }
    });
  }

  void handleScroll() {
    double offsetPage = _pageController.page;
    if (offsetPage < 0 || offsetPage > listLength - 1) {
      return;
    }

    if (offsetPage > lastOffset) {
      nextPage = offsetPage.ceil();
      currentPage = offsetPage.floor();
      isSwipeRight = true;
    } else if (offsetPage < lastOffset) {
      nextPage = offsetPage.floor();
      currentPage = offsetPage.ceil();
      isSwipeRight = false;
    } else {
      nextPage = currentPage;
    }

    double offsetOnePage = offsetPage - offsetPage.floor();
    _streamOffsetController.add(offsetOnePage);

    lastOffset = offsetPage;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.listUrlImgs.isListEmpty()) {
      return Container();
    }

    return Column(
      children: <Widget>[
        _buildListImages(),
        SizedBox(
          height: 12,
        ),
        _buildDots(),
      ],
    );
  }

  Widget _buildListImages() {
    return Container(
      height: Constants.heightSliderImageLoading,
      child: PageView.builder(
        controller: _pageController,
        itemBuilder: (BuildContext context, int index) {
          return MyFadeImage(widget.listUrlImgs[index]);
        },
        itemCount: listLength,
      ),
    );
  }

  Widget _buildDots() {
    return Container(
      height: 4,
      child: StreamBuilder<double>(
          stream: offsetStream,
          initialData: 0,
          builder: (context, snapshot) {
            double percentScroll = snapshot.data ?? 0;
            if (!isSwipeRight) {
              percentScroll = percentScroll != 0 ? 1 - percentScroll : 0;
            }

            return ListView.builder(
              padding: EdgeInsets.all(0),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                double widthContainer = 4;
                if (index == currentPage) {
                  widthContainer = 16 - percentScroll * 12;
                } else if (index == nextPage) {
                  widthContainer = 4 + percentScroll * 12;
                }

                return AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  width: widthContainer,
                  height: 4,
                  margin: EdgeInsets.only(right: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: index == currentPage
                          ? MyColor.activeDot
                          : MyColor.dot),
                );
              },
              itemCount: listLength,
            );
          }),
    );
  }

  @override
  void dispose() {
    _pageController?.dispose();
    _streamOffsetController?.close();
    super.dispose();
  }
}
