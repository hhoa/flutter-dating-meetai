import 'package:flutter_dating_meetai/bloc/bloc_base.dart';
import 'package:flutter_dating_meetai/models/profile_model.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProfileBloc extends BlocBase {
  BehaviorSubject<ProfileModel> _mainController = BehaviorSubject();
  Stream<ProfileModel> get mainStream => _mainController.stream;

  @override
  void dispose() {
    _mainController.close();
  }

}