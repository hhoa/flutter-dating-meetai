import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';

class LoveSliderBar extends StatefulWidget {
  final String name;

  LoveSliderBar(this.name);

  @override
  _LoveSliderBarState createState() => _LoveSliderBarState();
}

class _LoveSliderBarState extends State<LoveSliderBar> {
  double value = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          _buildText(),
          SizedBox(
            height: 30,
          ),
          _buildSlider(),
        ],
      ),
    );
  }

  Widget _buildText() {
    return Row(
      children: <Widget>[
        Icon(
          Icons.favorite,
          size: Constants.sizeHeart,
          color: MyColor.redIcon,
        ),
        SizedBox(
          width: 12,
        ),
        Expanded(
          child: Text(
            "How much do you like ${widget.name}?",
            style: MyAssetFont.boldAvatar,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildSlider() {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: MyColor.redIcon,
        inactiveTrackColor: MyColor.inactiveSlider,
        trackShape: CustomTrackShape(),
        trackHeight: 4.0,
        thumbColor: MyColor.redIcon,
        thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10.0),
        overlayColor: Colors.red.withAlpha(32),
        valueIndicatorColor: MyColor.redIcon,
      ),
      child: Slider(
        value: value,
        onChanged: (double value) {
          setState(() {
            this.value = value;
          });
        },
        min: 0,
        max: 100,
        divisions: 100,
        label: "${value.toInt()}",
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
