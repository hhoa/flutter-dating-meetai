import 'package:flutter/material.dart';
import 'package:flutter_dating_meetai/res/colors.dart';
import 'package:flutter_dating_meetai/res/constants.dart';
import 'package:flutter_dating_meetai/res/fonts.dart';
import 'package:flutter_dating_meetai/utils/utility.dart';

class HobbiesAndSong extends StatelessWidget {
  final List<String> hobbies;
  final List<String> songs;

  HobbiesAndSong(this.hobbies, this.songs);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildHobbies(),
        SizedBox(
          height: 12,
        ),
        _buildSongs(),
      ],
    );
  }

  Widget _buildHobbies() {
    if (hobbies.isListEmpty()) return Container();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Wrap(
        spacing: 8,
        runSpacing: 0,
        alignment: WrapAlignment.spaceBetween,
        children: List.generate(hobbies.length + 1, (index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Hobbies",
                style: MyAssetFont.boldName,
                textAlign: TextAlign.center,
              ),
            );
          }

          return Chip(
            padding: EdgeInsets.symmetric(horizontal: 2),
            label: Text(
              hobbies[index - 1],
              style: MyAssetFont.boldChip,
            ),
            avatar: Icon(
              Icons.whatshot,
              color: Colors.white,
              size: Constants.sizeHeart,
            ),
            backgroundColor: MyColor.hobbiesChip,
          );
        }),
      ),
    );
  }

  Widget _buildSongs() {
    if (songs.isListEmpty()) return Container();

    return Container(
      height: 32,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.only(left: 16),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                "Songs",
                style: MyAssetFont.boldName,
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Chip(
              padding: EdgeInsets.symmetric(horizontal: 2),
              label: Text(
                songs[index - 1],
                style: MyAssetFont.boldChip,
              ),
              avatar: Icon(
                Icons.music_note,
                color: Colors.white,
                size: Constants.sizeHeart,
              ),
              backgroundColor: MyColor.songsChip,
            ),
          );
        },
        itemCount: songs.length + 1,
      ),
    );
  }
}
