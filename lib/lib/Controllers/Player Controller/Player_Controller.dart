
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:permission_handler/permission_handler.dart';

class PlayerController extends GetxController {
  final AudioPlayer audioPlayer = AudioPlayer();

  Future<List<String>> fetchSongs() async {
    var permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      // Picking audio files using File Picker
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.audio,
        allowMultiple: true,
      );

      if (result != null) {
        return result.paths.whereType<String>().toList();
      } else {
        return Future.error('No songs selected');
      }
    } else {
      return Future.error('Permission denied');
    }
  }

  void playSong(String songPath) {
    audioPlayer.setFilePath(songPath);
    audioPlayer.play();
  }

  @override
  void onClose() {
    audioPlayer.dispose();
    super.onClose();
  }
}
