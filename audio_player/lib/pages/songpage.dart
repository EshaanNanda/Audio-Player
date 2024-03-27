import 'package:audio_player/components/neu_box.dart';
import 'package:audio_player/models/playlist_provider.dart';
import 'package:audio_player/pages/favourites_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class SongPage extends StatefulWidget {
  SongPage({Key? key}) : super(key: key);

  @override
  State<SongPage> createState() => _SongPageState();
}

class _SongPageState extends State<SongPage> {
  bool isFav = false;
  String formatTime(Duration duration) {
    String twoDigitSeconds =
        duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    String formattedTime = "${duration.inMinutes}:$twoDigitSeconds";

    return formattedTime;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        //get playlist
        final playlist = value.playlist;
        final favProvider = Provider.of<FavProvider>(context);
        final currentSong = playlist[value.currentSongIndex ?? 0];


        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //app bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //backbutton
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                      ),

                      //title
                      Center(
                        child: Text("P L A Y L I S T"),
                      ),

                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.menu),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  NeuBox(
                    child: Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.asset(currentSong.albumArtImagePath),
                        ),

                        //song and artistsname
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              //song and arist name
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    currentSong.songName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  Text(currentSong.artistsName),
                                ],
                              ),
                              //heart icon
                              IconButton(
                                onPressed: () {
                                  setState(
                                    () {
                                      favProvider.toggleFavourite(
                                          currentSong.songName);
                                    },
                                  );
                                },
                                icon: favProvider.isExist(currentSong.songName)
                                    ? Icon(
                                        Icons.favorite,
                                        color: Colors.red,
                                      )
                                    : Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                      ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //song duration progress
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //start time

                            Text(formatTime(value.currentDuration)),

                            //shuffle icon
                            IconButton(
                              onPressed: () {
                                setState(
                                  () {
                                    value.toggleShuffle(!value.isShuffle);
                                  },
                                );
                              },
                              icon: value.issShuffle()
                                  ? Icon(Icons.shuffle,color: Colors.green,)
                                  : Icon(
                                      Icons.shuffle,

                                    ),
                            ),

                            //repeat icon
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.repeat),
                            ),

                            //end time
                            Text(formatTime(value.totalDuration)),
                          ],
                        ),
                      ),
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 0),
                        ),
                        child: Slider(
                          min: 0,
                          max: value.totalDuration.inSeconds.toDouble(),
                          activeColor: Colors.green,
                          value: value.currentDuration.inSeconds.toDouble(),
                          onChanged: (double double) {},
                          onChangeEnd: (double double) {
                            value.seek(
                              Duration(
                                seconds: double.toInt(),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),

                  //playback controls
                  Row(
                    children: [
                      //skip previous
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playPrevioiusSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_previous),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),

                      //play pause
                      Expanded(
                        flex: 2,
                        child: GestureDetector(
                          onTap: value.pauseOrResume,
                          child: NeuBox(
                            child: Icon(value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 25,
                      ),

                      //skip forward
                      Expanded(
                        child: GestureDetector(
                          onTap: value.playNextSong,
                          child: NeuBox(
                            child: Icon(Icons.skip_next),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
