

import 'package:audio_player/models/song.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

class PlaylistProvider extends ChangeNotifier {
  final List<Song> _playlist = [
    Song(
        songName: "Kingston",
        artistsName: 'Faye Webster',
        albumArtImagePath: 'assets/images/Kingston.jpg',
        audioPath: 'audio/Kingston.mp3'),
    Song(
        songName: "Tek it",
        artistsName: 'Cafune',
        albumArtImagePath: 'assets/images/Cafune.jpeg',
        audioPath: 'audio/Tek it.mp3'),
    Song(
        songName: "Daddy Issues",
        artistsName: 'NBHD',
        albumArtImagePath: 'assets/images/Neighbourhood.jpg',
        audioPath: 'audio/Daddy Issues.mp3'),
  ];
  //current song playing index
  int? _shuffleIdx;
  int? _currentSongIndex;
  /*
   *
   * */

  //audio player
  final AudioPlayer _audioPlayer = AudioPlayer();


  //durations
  Duration _currentDuration = Duration.zero;
  Duration _totalDuration = Duration.zero;

  //constructor
  PlaylistProvider() {
    listenToDuration();
  }

  //initially not playing
  bool _isShuffle = false;
  bool _isActive = false;
  bool _isPlaying = false;

  //play the song
  void play() async {
    final String path = _playlist[_currentSongIndex!].audioPath;
    await _audioPlayer.stop();
    await _audioPlayer.play(AssetSource(path));
    _isActive = true;
    _isPlaying = true;
    notifyListeners();
  }

  //pause current song
  void pause() async {
    await _audioPlayer.pause();
    _isPlaying = false;
    notifyListeners();
  }

  //resume playing
  void resume() async {
    await _audioPlayer.resume();
    _isPlaying = true;
    notifyListeners();
  }

  //pause or resume
  void pauseOrResume() async {
    if (_isPlaying) {
      pause();
    } else {
      resume();
    }
    notifyListeners();
  }

  //seeek to a specific posn
  void seek(Duration position) async {
    await _audioPlayer.seek(position);
  }

  //play next song
  void playNextSong() {
    // if (_isShuffle) {
    //   int newIndex;
    //   do {
    //     newIndex = shuffle();
    //   } while (newIndex ==
    //       _currentSongIndex); // Keep generating new index if it's the same as the current index
    //   shuffleIdx = newIndex;
    // }
    if (_currentSongIndex != null) {
      if (_currentSongIndex! < _playlist.length - 1) {
        currentSongIndex = _currentSongIndex! + 1;
      } else {
        currentSongIndex = 0;
      }
    }
  }

  //play previous song
  void playPrevioiusSong() async {
    if (_currentDuration.inSeconds > 2) {
      seek(Duration.zero);
    } else {
      if (_currentSongIndex! > 0) {
        currentSongIndex = _currentSongIndex! - 1;
      } else {
        currentSongIndex = _playlist.length - 1;
      }
    }
  }

  //list to durations
  void listenToDuration() {
    //listen for total duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      _totalDuration = newDuration;
      notifyListeners();
    });
    //listen for current time
    _audioPlayer.onPositionChanged.listen((newPosition) {
      _currentDuration = newPosition;
      notifyListeners();
    });

    //listen for complete
    _audioPlayer.onPlayerComplete.listen((event) {
      playNextSong();
    });
  }



  // int shuffle() async{
  //   await _audioPlayer.shuffle();
  //   Random random = Random();
  //
  //   // Define the range
  //   int min = 0;
  //   int max = playlist.length - 1;
  //
  //   // Generate a random number within the range [min, max]
  //   int randomIdx = min + random.nextInt(max - min + 1);
  //
  //   return randomIdx;
  // }

  List<Song> get playlist => _playlist;
  int? get shuffleidx => _shuffleIdx;
  int? get currentSongIndex => _currentSongIndex;
  bool get isPlaying => _isPlaying;
  bool get isActive => _isActive;
  bool get isShuffle => _isShuffle;
  Duration get currentDuration => _currentDuration;
  Duration get totalDuration => _totalDuration;

  set issActive(bool val) {
    _isActive = val;
  }

  void toggleShuffle(bool val){
    final isExists=val;
    if(isExists){
      _isShuffle=true;

    }else{
      _isShuffle=false;
    }
    notifyListeners();
  }

  bool issShuffle(){
    return _isShuffle;
  }
  // set issShuffle(bool val) {
  //   _isShuffle = val;
  // }

  // set shuffleIdx(int? newIdx) {
  //   _shuffleIdx = newIdx;
  //   if (newIdx != null) {
  //     play();
  //   }
  //   notifyListeners();
  // }

  //setter mehodds
  set currentSongIndex(int? newIndex) {
    //update song index
    _currentSongIndex = newIndex;
    if (newIndex != null) {
      play();
    }

    notifyListeners();
  }
}
