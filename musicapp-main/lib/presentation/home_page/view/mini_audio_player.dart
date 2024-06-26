import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:musicapp/presentation/player_page/controller/player_controller.dart';
import 'package:musicapp/presentation/player_page/view/player.dart';

class MiniAudioPlayer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var controller = Get.find<Playercontroller>();
    var controller1 = Get.put(Playercontroller());

    return Padding(
      padding: const EdgeInsets.only(left: 33),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => Player(data: controller1.songs),
            ),
          );
        },
        child: Container(
          height: 70,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black,
          ),
          child: Stack(
            alignment: Alignment.centerRight,
            children: [
              Obx(() {
                var currentSong = controller.songs.isNotEmpty
                    ? controller.songs[controller.playIndex.value]
                    : null;

                return Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (controller.isplaying.value) {
                          controller.audioPlayer.pause();
                        } else {
                          controller.audioPlayer.play();
                        }
                        controller.isplaying.toggle();
                      },
                      icon: Icon(
                        controller.isplaying.value
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 2),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentSong != null ? currentSong.title : '',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            currentSong != null
                                ? currentSong.artist.toString()
                                : '',
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
