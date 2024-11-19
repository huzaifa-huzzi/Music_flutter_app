import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class PlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var currentSong = ''.obs;
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.positionStream.listen((pos) {
      position.value = pos;
    });
    _audioPlayer.durationStream.listen((dur) {
      duration.value = dur ?? Duration.zero;
    });
    _audioPlayer.playerStateStream.listen((state) {
      isPlaying.value = state.playing;
    });
  }

  Future<void> playSong(String path) async {
    try {
      currentSong.value = path;
      await _audioPlayer.setFilePath(path);
      await _audioPlayer.play();
    } catch (e) {
      print("Error playing song: $e");
    }
  }

  void pauseSong() {
    _audioPlayer.pause();
  }

  void resumeSong() {
    _audioPlayer.play();
  }

  void stopSong() {
    _audioPlayer.stop();
  }

  void seekSong(Duration position) {
    _audioPlayer.seek(position);
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
