import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/models/moment.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';
import 'package:flutter_dating_meetai/utils/screen_utils.dart';
import 'package:flutter_dating_meetai/utils/utility.dart';
import 'package:flutter_dating_meetai/widgets/bouncing_button.dart';
import 'package:flutter_dating_meetai/widgets/chip_outline_border.dart';
import 'package:flutter_dating_meetai/widgets/my_fade_image.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class UserMoments extends StatefulWidget {
  final List<Moment> moments;

  UserMoments(this.moments);

  @override
  _UserMomentsState createState() => _UserMomentsState();
}

class _UserMomentsState extends BaseState<UserMoments> {
  int get listLength => widget.moments.length;

  int childCount = 0;
  List<int> listFirstIndex = [];

  @override
  void initState() {
    super.initState();

    if (widget.moments.isListNotEmpty()) {
      listFirstIndex.add(0);
      childCount = widget.moments[0].images.length;
      for (int i = 1; i < widget.moments.length; i++) {
        childCount += widget.moments[i].images.length;
        listFirstIndex
            .add(listFirstIndex.last + widget.moments[i - 1].images.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.moments.isListEmpty()) {
      return Container();
    }

    return StaggeredGridView.builder(
      itemCount: childCount + 1,
      physics: ClampingScrollPhysics(),
      addAutomaticKeepAlives: false,
      shrinkWrap: false,
      padding: EdgeInsets.all(0),
      gridDelegate: SliverStaggeredGridDelegateWithFixedCrossAxisCount(
        staggeredTileBuilder: (int index) {
          if (listFirstIndex.contains(index) || index == childCount) {
            return StaggeredTile.fit(4);
          }

          return (index % 3 == 1 || index % 3 == 2)
              ? StaggeredTile.fit(2)
              : StaggeredTile.fit(4);
        },
        crossAxisCount: 4,
        mainAxisSpacing: 0,
        crossAxisSpacing: 0,
        staggeredTileCount: childCount + 1,
      ),
      itemBuilder: (context, index) {
        if (index == childCount) {
          return _buildEndOfList();
        }

        int momentIndex = 0;
        int imageIndex = 0;

        if (listFirstIndex.length == 1) {
          imageIndex = index;
        } else {
          for (int i = 0; i < listFirstIndex.length; i++) {
            if ((i == (listFirstIndex.length - 1)) ||
                (index < listFirstIndex[i + 1])) {
              momentIndex = i;
              if (index >= listFirstIndex[i]) {
                imageIndex = index - listFirstIndex[i];
              } else {
                imageIndex = index;
              }
              break;
            }
          }
        }

        if (index == listFirstIndex[momentIndex]) {
          return buildFullInfoImage(momentIndex, imageIndex);
        } else {
          return buildImage(momentIndex, imageIndex);
        }
      },
    );
  }

  Widget buildFullInfoImage(int momentIndex, int imageIndex) {
    Moment moment = widget.moments[momentIndex];

    return Container(
      width: screenSize.width,
      height: screenSize.width,
      child: Stack(
        children: <Widget>[
          Positioned.fill(
            child: buildImage(momentIndex, imageIndex),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: ChipOutlineBorder(
              icon: Icons.location_on,
              text: moment.location,
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: Text(
              "${moment.date.differenceInDays()} days ago",
              style: MyAssetFont.boldWhite,
            ),
          )
        ],
      ),
    );
  }

  Widget buildImage(int momentIndex, int imageIndex) {
    return BouncingButton(
      onTap: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return Scaffold(
                backgroundColor: Colors.black.withOpacity(0.8),
                body: SafeArea(
                  child: Stack(
                    children: <Widget>[
                      Positioned.fill(
                        child: Dismissible(
                          key: ValueKey("MyFadeImage$momentIndex$imageIndex"),
                          onDismissed: (_) => closeDialog(),
                          direction: DismissDirection.down,
                          child: MyFadeImage(
                            widget.moments[momentIndex].images[imageIndex],
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 16,
                        top: 16,
                        child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.white,
                          ),
                          onPressed: closeDialog,
                        ),
                      )
                    ],
                  ),
                ),
              );
            });
      },
      shrinkOffset: 0.96,
      child: MyFadeImage(
        widget.moments[momentIndex].images[imageIndex],
      ),
    );
  }

  Widget _buildEndOfList() {
    return Container(
      padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
                height: 1,
                color: MyColor.grey),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "You reach the end of list",
              style: MyAssetFont.boldAvatar,
            ),
          ),
          Expanded(
            child: Container(
                height: 1,
                color: MyColor.grey),
          ),
        ],
      ),
    );
  }

  void closeDialog() => Navigator.of(context).pop();
}
