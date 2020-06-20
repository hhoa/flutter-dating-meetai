import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/bloc/bloc_provider.dart';
import 'package:flutter_dating_meetai/bloc/profile_bloc.dart';
import 'package:flutter_dating_meetai/models/profile_model.dart';
import 'package:flutter_dating_meetai/screens/loading_profile_screen.dart';
import 'package:flutter_dating_meetai/utils/screen_utils.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  ProfileBloc _bloc;

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ProfileBloc>(context);
    _bloc.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        left: false,
        right: false,
        bottom: false,
        child: StreamBuilder<ProfileModel>(
          stream: _bloc.mainStream,
          builder: (context, snapshot) {
            ProfileModel model = snapshot.data;

            if (model == null) {
              return LoadingProfileScreen();
            }

            return _buildContentPage(model);
          }
        ),
      ),
    );
  }

  Widget _buildContentPage(ProfileModel model) {
    return Container();
  }
}
