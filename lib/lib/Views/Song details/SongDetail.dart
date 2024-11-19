import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_2/lib/Controllers/Player%20Controller/Player_Controller.dart';

class SongDetails extends StatelessWidget {
  final String songPath;
  final String songName;
  final String artistName;

  const SongDetails({super.key, required this.songPath, required this.songName, this.artistName = "Artist name"});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlayerController>();

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            controller.stopSong();
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular artwork container (optional)
          Container(
            width: 250,
            height: 250,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.music_note,
                color: Colors.black,
                size: 100,
              ),
            ),
          ),
          const SizedBox(height: 50),
          // Song and artist information
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  songName,
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                const SizedBox(height: 10),
                Text(
                  artistName,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                // Song progress bar
                Obx(() {
                  String formatDuration(Duration duration) {
                    String twoDigits(int n) => n.toString().padLeft(2, '0');
                    final minutes = twoDigits(duration.inMinutes);
                    final seconds = twoDigits(duration.inSeconds.remainder(60));
                    return '$minutes:$seconds';
                  }

                  final currentTime = formatDuration(Duration(seconds: controller.progress.value.toInt()));
                  final totalTime = controller.audioPlayer.duration != null
                      ? formatDuration(controller.audioPlayer.duration!)
                      : '00:00';

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(currentTime, style: const TextStyle(color: Colors.black)),
                      Expanded(
                        child: Slider(
                          value: controller.progress.value,
                          max: controller.audioPlayer.duration?.inSeconds.toDouble() ?? 0.0,
                          onChanged: (value) {
                            controller.audioPlayer.seek(Duration(seconds: value.toInt()));
                          },
                          activeColor: Colors.purple,
                          inactiveColor: Colors.grey,
                        ),
                      ),
                      Text(totalTime, style: const TextStyle(color: Colors.black)),
                    ],
                  );
                }),
                const SizedBox(height: 20),
                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.skip_previous, color: Colors.black, size: 36),
                      onPressed: () => controller.previousSong(),
                    ),
                    Obx(() {
                      return IconButton(
                        icon: Icon(
                          controller.isPlaying.value
                              ? Icons.pause_circle_filled
                              : Icons.play_circle_fill,
                          color: Colors.black,
                          size: 50,
                        ),
                        onPressed: () {
                          if (controller.isPlaying.value) {
                            controller.pauseSong();
                          } else {
                            controller.playSong(songPath);
                          }
                        },
                      );
                    }),
                    IconButton(
                      icon: const Icon(Icons.skip_next, color: Colors.black, size: 36),
                      onPressed: () => controller.nextSong(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
