import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/bloc/bloc_provider.dart';
import 'package:flutter_dating_meetai/bloc/profile_bloc.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';

class PulseHeart extends StatefulWidget {
  @override
  _PulseHeartState createState() => _PulseHeartState();
}

class _PulseHeartState extends State<PulseHeart> with TickerProviderStateMixin {
  ProfileBloc _bloc;

  AnimationController _inactiveController;
  Animation<double> inactiveAnimation;

  AnimationController _activeController;
  Animation<double> scaleActiveAnimation1;
  Animation<double> opacityActiveAnimation1;
  Animation<double> scaleActiveAnimation2;
  Animation<double> opacityActiveAnimation2;

  Curve curvePulse = Curves.easeOut;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ProfileBloc>(context);
    initAnimation();
  }

  void initAnimation() {
    _inactiveController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    inactiveAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
        CurvedAnimation(parent: _inactiveController, curve: Curves.easeOut));
    _activeController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1800));

    scaleActiveAnimation1 = Tween<double>(
      begin: 1,
      end: 1.8,
    ).animate(
      CurvedAnimation(
        parent: _activeController,
        curve: Interval(
          0,
          0.6,
          curve: curvePulse,
        ),
      ),
    );

    opacityActiveAnimation1 = Tween<double>(
      begin: 0.6,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _activeController,
        curve: Interval(
          0.3,
          0.6,
          curve: curvePulse,
        ),
      ),
    );

    scaleActiveAnimation2 = Tween<double>(
      begin: 1,
      end: 1.8,
    ).animate(
      CurvedAnimation(
        parent: _activeController,
        curve: Interval(
          0.3,
          1,
          curve: curvePulse,
        ),
      ),
    );

    opacityActiveAnimation2 = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _activeController,
        curve: Interval(
          0.7,
          1,
          curve: curvePulse,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _bloc.changeHeart();
      },
      child: StreamBuilder<bool>(
          stream: _bloc.isActiveLoveStream,
          builder: (context, snapshot) {
            bool isActiveLove = snapshot.data ?? _bloc.isActiveLove;
            if (isActiveLove) {
              _inactiveController.reset();
              _activeController.repeat();
            } else {
              _activeController.reset();
              _inactiveController.repeat(reverse: true);
            }

            return !isActiveLove ? _buildInactiveHeart() : _buildActiveHeart();
          }),
    );
  }

  Widget _buildInactiveHeart() {
    return ScaleTransition(
      scale: inactiveAnimation,
      child: Icon(
        Icons.favorite_border,
        color: MyColor.redIcon,
        size: 26,
      ),
      alignment: Alignment.center,
    );
  }

  Widget _buildActiveHeart() {
    return Container(
      width: Constants.sizeHeart,
      height: Constants.sizeHeart,
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          AnimatedBuilder(
            animation: _activeController,
            builder: (context, child) {
              return Stack(
                children: <Widget>[
                  Opacity(
                    opacity: opacityActiveAnimation2.value,
                    child: Transform.scale(
                      scale: scaleActiveAnimation2.value,
                      child: child,
                    ),
                  ),
                  Opacity(
                    opacity: opacityActiveAnimation1.value,
                    child: Transform.scale(
                      scale: scaleActiveAnimation1.value,
                      child: child,
                    ),
                  ),
                ],
              );
            },
            child: Icon(
              Icons.favorite,
              color: MyColor.redIcon.withAlpha(125),
              size: Constants.sizeHeart,
            ),
          ),
          Icon(
            Icons.favorite,
            color: MyColor.redIcon,
            size: Constants.sizeHeart,
          )
        ],
      ),
    );
  }
}
