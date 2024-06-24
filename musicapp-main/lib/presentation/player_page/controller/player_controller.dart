import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var songs = List<SongModel>.empty().obs;

  var playIndex = 0.obs;
  var isplaying = false.obs;

  var duriation = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    checkpermission();
    // Listen to playback events
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSong();
      }
    });
  }

  updatePosition() {
    audioPlayer.durationStream.listen((d) {
      duriation.value = d.toString().split(".")[0];
      max.value = d!.inSeconds.toDouble();
    });
    audioPlayer.positionStream.listen((p) {
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();
    });
  }

  changeDurationToSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playsong(String? uri, int index) async {
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(Uri.parse(uri!)),
      );
      await audioPlayer.play();
      isplaying.value = true;
      updatePosition();
    } catch (e) {
      print(e.toString());
    }
  }

  nextSong() async {
    int nextIndex = playIndex.value + 1;
    if (nextIndex < songs.length) {
      await playsong(songs[nextIndex].uri, nextIndex);
    }
  }

  checkpermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      // Query songs if permission is granted
      await querySongs();
    } else {
      checkpermission(); // Retry until permission is granted
    }
  }

  // Method to query songs using OnAudioQuery
  Future<void> querySongs() async {
    songs.value = await audioQuery.querySongs(
      ignoreCase: true,
      orderType: OrderType.ASC_OR_SMALLER,
      sortType: null,
      uriType: UriType.EXTERNAL,
    );
  }
}
