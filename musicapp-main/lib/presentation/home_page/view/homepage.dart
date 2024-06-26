import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/presentation/home_page/view/mini_audio_player.dart';
import 'package:musicapp/presentation/player_page/controller/player_controller.dart';
import 'package:musicapp/presentation/player_page/view/player.dart';
import 'package:musicapp/core/constants/textstyle_constants/style.dart';
import 'package:musicapp/core/constants/color_constants/colors.dart';
import 'package:musicapp/presentation/setting_screen/view/setting_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(Playercontroller());
    TextEditingController searchController = TextEditingController();

    return Scaffold(
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
                // Filtered list based on search query
                var filteredSongs = songs
                    .where((song) =>
                        song.displayNameWOExt
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()) ||
                        song.artist!
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                    .toList();

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: searchController,
                        style: Ourstyle(),
                        decoration: InputDecoration(
                          labelText: 'Search songs...',
                          labelStyle: Ourstyle(),
                          prefixIcon: Icon(Icons.search, color: Colors.white),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.clear, color: Colors.white),
                            onPressed: () {
                              searchController.clear();
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
                          controller.updateFilteredSongs(value);
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: filteredSongs.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: ListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                tileColor: bgColor,
                                title: Text(
                                  filteredSongs[index].displayNameWOExt,
                                  style: Ourstyle(),
                                ),
                                subtitle: Text(
                                  "${filteredSongs[index].artist}",
                                  style: Ourstyle(),
                                ),
                                leading: QueryArtworkWidget(
                                  id: filteredSongs[index].id,
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
                                      data: filteredSongs,
                                    ),
                                    transition: Transition.downToUp,
                                  );
                                  controller.playsong(
                                      filteredSongs[index].uri, index);
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              }
            });
          }
        },
      ),
      floatingActionButton: MiniAudioPlayer(),
    );
  }
}
