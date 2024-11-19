import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:file_picker/file_picker.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();
  List<String> songs = [];
  int currentIndex = 0; // To track the current song index

  RxBool isPlaying = false.obs; // Track if the song is playing
  RxDouble progress = 0.0.obs; // To store song progress

  bool _isFilePickerActive = false; // Flag to prevent multiple file picker calls

  // Fetch songs from storage
  Future<List<String>> fetchSongs() async {
    if (_isFilePickerActive) {
      // Prevent multiple file picker actions at once
      return Future.error('File picker is already active.');
    }

    var permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      _isFilePickerActive = true; // Mark the picker as active

      // Pick audio files using File Picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      _isFilePickerActive = false; // Reset the flag once the picker is done

      if (result != null) {
        songs = result.paths.whereType<String>().toList();
        return songs;
      } else {
        return Future.error('No songs selected');
      }
    } else {
      return Future.error('Permission denied');
    }
  }

  // Play the song
  void playSong(String songPath) async {
    await audioPlayer.setFilePath(songPath);
    audioPlayer.play();
    isPlaying.value = true;
    _listenForProgress();
  }

  // Pause the song
  void pauseSong() {
    audioPlayer.pause();
    isPlaying.value = false;
  }

  // Stop the song
  void stopSong() {
    audioPlayer.stop();
    isPlaying.value = false;
    progress.value = 0.0; // Reset progress
  }

  // Skip to the next song
  void nextSong() {
    if (currentIndex < songs.length - 1) {
      currentIndex++;
      playSong(songs[currentIndex]);
    }
  }

  // Skip to the previous song
  void previousSong() {
    if (currentIndex > 0) {
      currentIndex--;
      playSong(songs[currentIndex]);
    }
  }

  // Listen for progress and update UI
  void _listenForProgress() {
    audioPlayer.positionStream.listen((position) {
      progress.value = position.inSeconds.toDouble();
    });
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
