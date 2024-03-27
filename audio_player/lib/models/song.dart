import 'package:flutter/material.dart';

class Song {
  late final String songName;
  late final String artistsName;
  late final String albumArtImagePath;
  late final String audioPath;
  Song(
      {required this.songName,
      required this.artistsName,
      required this.albumArtImagePath,
      required this.audioPath});
}
