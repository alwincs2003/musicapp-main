import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Playercontroller extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  var songs = List<SongModel>.empty().obs;
  var filteredSongs = List<SongModel>.empty().obs;

  var playIndex = 0.obs;
  var isplaying = false.obs;

  var duriation = ''.obs;
  var position = ''.obs;

  var max = 0.0.obs;
  var value = 0.0.obs;

  TextEditingController searchController = TextEditingController();
  var isMiniPlayerVisible = true.obs;

  @override
  void onInit() {
    super.onInit();
    checkPermission();
    // Listen to playback events
    audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        nextSong();
      }
    });

    // Listen to search text changes
    searchController.addListener(() {
      updateFilteredSongs(
        searchController.text.trim(),
      );
    });
  }

  // Method to update filtered songs based on search text
  updateFilteredSongs(String searchText) {
    if (searchText.isEmpty) {
      filteredSongs.assignAll(songs); // Show all songs if search text is empty
    } else {
      var lowercaseQuery = searchText.toLowerCase();
      var filteredList = songs.where(
        (song) =>
            song.title.toLowerCase().contains(lowercaseQuery) ||
            (song.artist != null &&
                song.artist!.toLowerCase().contains(lowercaseQuery)),
      );

      // Sort filtered list alphabetically by song title
      filteredList = filteredList.toList()
        ..sort((a, b) => a.title.compareTo(b.title));

      filteredSongs.assignAll(filteredList);
    }

    // Handle playback stop if filteredSongs becomes empty
    if (filteredSongs.isEmpty && isplaying.value) {
      stopPlayback();
    }
  }

  // Method to handle search text changes
  void onSearchTextChanged(String text) {
    updateFilteredSongs(
      text.trim(),
    );
  }

  updatePosition() {
    audioPlayer.durationStream.listen(
      (d) {
        duriation.value = d.toString().split(".")[0];
        max.value = d!.inSeconds.toDouble();
      },
    );
    audioPlayer.positionStream.listen(
      (p) {
        position.value = p.toString().split(".")[0];
        value.value = p.inSeconds.toDouble();
      },
    );
  }

  changeDurationToSeconds(int seconds) {
    var duration = Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }

  playsong(String? uri, int index) async {
    playIndex.value = index;
    try {
      await audioPlayer.setAudioSource(
        AudioSource.uri(
          Uri.parse(uri!),
        ),
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
    if (nextIndex < filteredSongs.length) {
      await playsong(filteredSongs[nextIndex].uri, nextIndex);
    } else {
      stopPlayback(); // No more songs to play, stop playback
    }
  }

  stopPlayback() {
    audioPlayer.stop();
    isplaying.value = false;
    // Optionally reset playIndex or perform other cleanup
  }

  checkPermission() async {
    var perm = await Permission.storage.request();
    if (perm.isGranted) {
      // Query songs if permission is granted
      await querySongs();
    } else {
      checkPermission(); // Retry until permission is granted
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

    // Initially assign all songs to filteredSongs
    filteredSongs.assignAll(songs);
  }

  void toggleMiniPlayerVisibility() {
    isMiniPlayerVisible.value =
        !isMiniPlayerVisible.value; // Toggle visibility of mini player
  }
}
