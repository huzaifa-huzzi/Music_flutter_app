import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app_2/lib/Components/Colors/Colors.dart';
import 'package:music_app_2/lib/Components/Text_sTyle/text_Style.dart';
import 'package:music_app_2/lib/Controllers/Player%20Controller/Player_Controller.dart';
import 'dart:io';
import 'package:music_app_2/lib/Views/Song%20details/SongDetail.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(PlayerController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgDarkColor,
      appBar: AppBar(
        backgroundColor: bgDarkColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search, color: whiteColor),
          ),
        ],
        leading: const Icon(Icons.sort_rounded, color: whiteColor, size: 25),
        title: Text('Beats', style: ourStyle(family: bold, size: 25)),
      ),
      body: FutureBuilder<List<String>>(
        future: controller.fetchSongs(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "${snapshot.error}",
                style: ourStyle(),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                "No song",
                style: ourStyle(),
              ),
            );
          } else {
            return Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  var songPath = snapshot.data![index];
                  var songName = songPath.split('/').last;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    child: ListTile(
                      tileColor: bgColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      title: Text(
                        songName,
                        style: ourStyle(family: bold, size: 15),
                      ),
                      onTap: () {
                        controller.playSong(songPath); // Play the song
                        Get.to(() => SongDetails(songPath: songPath, songName: songName));
                      },
                      leading: FutureBuilder<bool>(
                        future: File(songPath).exists(),
                        builder: (context, artworkSnapshot) {
                          if (artworkSnapshot.connectionState == ConnectionState.waiting) {
                            return const CircularProgressIndicator();
                          }
                          if (artworkSnapshot.hasData && artworkSnapshot.data!) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                File(songPath),
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.music_note, color: whiteColor, size: 40);
                                },
                              ),
                            );
                          } else {
                            return const Icon(Icons.music_note, color: whiteColor, size: 40);
                          }
                        },
                      ),
                      trailing: const Icon(Icons.play_arrow, color: whiteColor, size: 26),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
