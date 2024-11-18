import 'package:flutter/material.dart';
import 'dart:io';

class SongDetails extends StatelessWidget {
  final String songPath;
  final String songName;
  final String artistName;

  const SongDetails({Key? key, required this.songPath, required this.songName, this.artistName = "Artist name"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Circular artwork container
          Container(
            width: 250,
            height: 250,
            decoration: BoxDecoration(
              color: Colors.red, // Placeholder color for artwork background
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Icon(
                Icons.music_note,
                color: Colors.black,
                size: 100,
              ),
            ),
          ),
          SizedBox(height: 50),
          // Song and artist information
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                Text(
                  songName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                ),
                SizedBox(height: 10),
                Text(
                  artistName,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                ),
                SizedBox(height: 20),
                // Song progress bar (dummy for now)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('0:00', style: TextStyle(color: Colors.black)),
                    Expanded(
                      child: Slider(
                        value: 0.2, // Dummy value
                        onChanged: (value) {},
                        activeColor: Colors.purple,
                        inactiveColor: Colors.grey,
                      ),
                    ),
                    Text('4:00', style: TextStyle(color: Colors.black)),
                  ],
                ),
                SizedBox(height: 20),
                // Playback controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Icon(Icons.skip_previous, color: Colors.black, size: 36),
                    Icon(Icons.play_circle_fill, color: Colors.black, size: 50),
                    Icon(Icons.skip_next, color: Colors.black, size: 36),
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
