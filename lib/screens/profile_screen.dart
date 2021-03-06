import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/bloc/bloc_provider.dart';
import 'package:flutter_dating_meetai/bloc/profile_bloc.dart';
import 'package:flutter_dating_meetai/models/profile.dart';
import 'package:flutter_dating_meetai/models/profile_model.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/screens/loading_profile_screen.dart';
import 'package:flutter_dating_meetai/utils/screen_utils.dart';
import 'package:flutter_dating_meetai/widgets/app_bar.dart';
import 'package:flutter_dating_meetai/widgets/hobbies_songs.dart';
import 'package:flutter_dating_meetai/widgets/list_horizontal_images.dart';
import 'package:flutter_dating_meetai/widgets/love_sliderbar.dart';
import 'package:flutter_dating_meetai/widgets/user_info.dart';
import 'package:flutter_dating_meetai/widgets/user_moments.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseState<ProfileScreen> {
  ProfileBloc _bloc;
  ScrollController nestedController = ScrollController();

  @override
  void initState() {
    super.initState();

    _bloc = BlocProvider.of<ProfileBloc>(context);
    _bloc.loadData();

    nestedController.addListener(() {
      double offset = nestedController.offset;
      _bloc.changeShadow(offset);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: MyColor.redIcon,
            brightness: Brightness.dark,
          ),
      ),
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

              return _buildContentPage(model.profile);
            }),
      ),
    );
  }

  Widget _buildContentPage(Profile model) {
    return Column(
      children: <Widget>[
        _buildAppBar(model.avatar, model.name),
        Expanded(
          child: NestedScrollView(
            physics: ClampingScrollPhysics(),
            controller: nestedController,
            headerSliverBuilder: (BuildContext context,
                bool innerBoxIsScrolled) {
              return <Widget>[
                _buildListHorizontal(model.images),
                _buildInfo(model),
                _buildChips(model.hobbies, model.songs),
                _buildSliderBar(model.username),
                _buildPadding(),
              ];
            },
            body: UserMoments(model.moment),
          ),
        ),
      ],
    );
  }

  Widget _buildAppBar(String avatar, String name) {
    return StreamBuilder<bool>(
      stream: _bloc.shadowStream,
      initialData: false,
      builder: (context, snapshot) {
        bool hasShadow = snapshot.data ?? false;
        return MyAppBar(avatar, name, hasShadow: hasShadow);
      }
    );
  }

  Widget _buildListHorizontal(List<String> images) {
    return SliverToBoxAdapter(
      child: ListHorizontalImages(images),
    );
  }

  Widget _buildInfo(Profile model) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 12),
        child: UserInfo(
          name: model.name,
          birthday: model.birthday,
          work: model.work,
          education: model.education,
          bio: model.bio,
        ),
      ),
    );
  }

  Widget _buildChips(List<String> hobbies, List<String> songs) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 12),
        child: HobbiesAndSong(hobbies, songs),
      ),
    );
  }

  Widget _buildSliderBar(String username) {
    return SliverToBoxAdapter(
      child: Container(
        margin: EdgeInsets.only(top: 12),
        child: LoveSliderBar(username),
      ),
    );
  }

  Widget _buildPadding() {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 32),
      sliver: SliverToBoxAdapter(
        child: Container(),
      ),
    );
  }

  @override
  void dispose() {
    nestedController.dispose();
    super.dispose();
  }
}
