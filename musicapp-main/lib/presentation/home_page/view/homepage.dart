import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:zmusic/presentation/player_page/controller/player_controller.dart';
import 'package:zmusic/presentation/player_page/view/player.dart';
import 'package:zmusic/presentation/setting_screen/view/setting_screen.dart';
import 'package:zmusic/presentation/home_page/view/mini_audio_player.dart';
import 'package:zmusic/core/constants/textstyle_constants/style.dart';
import 'package:zmusic/core/constants/color_constants/colors.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playercontroller());

    return SafeArea(
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SettingScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
          ],
          title: Text(
            "Musics",
            style: Ourstyle(),
          ),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller.searchController,
                style: Ourstyle(),
                decoration: InputDecoration(
                  labelText: 'Search songs...',
                  labelStyle: Ourstyle(),
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear, color: Colors.white),
                    onPressed: () {
                      controller.searchController.clear();
                      FocusScope.of(context).unfocus();
                    },
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.white),
                  ),
                ),
                onChanged: (value) {
                  controller.onSearchTextChanged(value);
                },
              ),
            ),
            Expanded(
              child: Obx(
                () {
                  var filteredSongs = controller.filteredSongs;
                  if (filteredSongs.isEmpty) {
                    return Center(
                      child: Text(
                        "No Song Found",
                        style: Ourstyle(),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: filteredSongs.length,
                      itemBuilder: (context, index) {
                        var song = filteredSongs[index];
                        return ListTile(
                          title: Text(
                            song.title,
                            style: Ourstyle(),
                          ),
                          subtitle: Text(
                            song.artist ?? 'Unknown Artist',
                            style: Ourstyle(),
                          ),
                          leading: QueryArtworkWidget(
                            id: song.id,
                            type: ArtworkType.AUDIO,
                            nullArtworkWidget: const Icon(
                              Icons.music_note,
                              color: textColor,
                              size: 32,
                            ),
                          ),
                          trailing: controller.playIndex.value == index &&
                                  controller.isplaying.value
                              ? Icon(
                                  Icons.play_arrow,
                                  color: textColor,
                                  size: 26,
                                )
                              : null,
                          onTap: () {
                            Get.to(
                              () => Player(data: filteredSongs),
                              transition: Transition.downToUp,
                            );
                            controller.playsong(song.uri, index);
                          },
                        );
                      },
                    );
                  }
                },
              ),
            ),
            Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: MiniAudioPlayer(),
            ),
          ],
        ),
      ),
    );
  }
}
