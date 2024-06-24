import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/presentation/home_page/view/mini_audio_player.dart';
import 'package:musicapp/presentation/player_page/controller/player_controller.dart';
import 'package:musicapp/presentation/player_page/view/player.dart';
import 'package:musicapp/core/constants/textstyle_constants/style.dart';
import 'package:musicapp/core/constants/color_constants/colors.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playercontroller());

    return Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgDarkColor,
          // actions: [
          //   IconButton(
          //     onPressed: () {},
          //     icon: Icon(
          //       Icons.search,
          //       color: textColor,
          //     ),
          //   ),
          // ],

          title: Text(
            "Musics",
            style: Ourstyle(),
          ),
        ),
        body: FutureBuilder(
          future: controller.querySongs(),
          builder: (BuildContext context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(
                  "Error loading songs: ${snapshot.error}",
                  style: Ourstyle(),
                ),
              );
            } else {
              return Obx(() {
                var songs = controller.songs;
                if (songs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Song Found",
                      style: Ourstyle(),
                    ),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: songs.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 4),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            tileColor: bgDarkColor,
                            title: Text(
                              songs[index].displayNameWOExt,
                              style: Ourstyle(),
                            ),
                            subtitle: Text(
                              "${songs[index].artist}",
                              style: Ourstyle(),
                            ),
                            leading: QueryArtworkWidget(
                              id: songs[index].id,
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
                                () => Player(
                                  data: songs,
                                ),
                                transition: Transition.downToUp,
                              );
                              controller.playsong(songs[index].uri, index);
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              });
            }
          },
        ),
        floatingActionButton: MiniAudioPlayer());
  }
}
