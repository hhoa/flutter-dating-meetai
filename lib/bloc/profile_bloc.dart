import 'package:flutter_dating_meetai/bloc/bloc_base.dart';
import 'package:flutter_dating_meetai/models/profile_model.dart';
import 'package:flutter_dating_meetai/utils/fakejson.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc extends BlocBase {
  BehaviorSubject<ProfileModel> _mainController = BehaviorSubject();
  Stream<ProfileModel> get mainStream => _mainController.stream;

  void loadData() {
    Future.delayed(Duration(seconds: 2), () {
      ProfileModel model = profileModelFromJson(FakeJson.fakeProfileJson);
      _mainController.add(model);
    });
  }

  @override
  void dispose() {
    _mainController.close();
  }

}