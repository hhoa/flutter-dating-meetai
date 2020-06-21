import 'package:flutter_dating_meetai/bloc/bloc_base.dart';
import 'package:flutter_dating_meetai/models/profile_model.dart';
import 'package:flutter_dating_meetai/utils/fakejson.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc extends BlocBase {
  BehaviorSubject<ProfileModel> _mainController = BehaviorSubject();
  Stream<ProfileModel> get mainStream => _mainController.stream;

  PublishSubject<bool> _shadowController = PublishSubject();
  Stream<bool> get shadowStream => _shadowController.stream;

  bool _hasShadow = false;

  BehaviorSubject<bool> _isActiveLoveController = BehaviorSubject();
  Stream<bool> get isActiveLoveStream => _isActiveLoveController.stream;
  bool isActiveLove = true;

  void loadData() {
    Future.delayed(Duration(milliseconds: 1000), () {
      ProfileModel model = profileModelFromJson(FakeJson.fakeProfileJson);
      _mainController.add(model);
    });
  }

  void changeShadow(double offset) {
    if (_hasShadow && offset == 0) {
      _hasShadow = false;
      _shadowController.add(_hasShadow);
    } else if (!_hasShadow && offset != 0) {
      _hasShadow = true;
      _shadowController.add(_hasShadow);
    }
  }

  void changeHeart() {
    isActiveLove = !isActiveLove;
    _isActiveLoveController.add(isActiveLove);
  }

  @override
  void dispose() {
    _mainController.close();
    _shadowController.close();
    _isActiveLoveController.close();
  }

}