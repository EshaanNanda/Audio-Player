import 'package:audio_player/components/My_drawer.dart';
import 'package:audio_player/models/playlist_provider.dart';
import 'package:flutter/material.dart';
import 'package:miniplayer/miniplayer.dart';
import 'package:provider/provider.dart';

import '../models/song.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //get the playlist provider
  late final dynamic playlistProvider;
  void initState() {
    super.initState();
    //get playlist provider
    playlistProvider = Provider.of<PlaylistProvider>(context, listen: false);
  }

  void goToSong(int songIndex) {
    //update the current song index
    playlistProvider.currentSongIndex = songIndex;

    Navigator.pushNamed(context, '/song');
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlaylistProvider>(
      builder: (context, value, child) {
        final playlist = value.playlist;

        //get current song idx
        final currentSong = playlist[value.currentSongIndex ?? 0];

        final sngProvider = Provider.of<PlaylistProvider>(context);

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(kToolbarHeight),
            child: AppBar(
              title: Text("P L A Y L I S T"),
              backgroundColor: Theme.of(context).colorScheme.background,
            ),
          ),
          drawer: MyDrawer(),
          body: Consumer<PlaylistProvider>(builder: (context, value, child) {
            //getb the playlists
            final List<Song> playlist = value.playlist;

            //return lists
            return Stack(children: [
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: playlist.length,
                      itemBuilder: (context, index) {
                        //get the individual song
                        final Song song = playlist[index];
                        //return list tile UII
                        return ListTile(
                          title: Text(song.songName),
                          subtitle: Text(song.artistsName),
                          leading: Image.asset(song.albumArtImagePath),
                          onTap: () => goToSong(index),
                        );
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      setState(() {
                        Navigator.pushNamed(context, 'song');
                      });

                    },
                    child: Miniplayer(
                      minHeight: 80,
                      maxHeight: 80,
                      builder: (height, percentage) {
                        if (sngProvider.isActive == false) {
                          return const SizedBox.shrink();
                        }
                        return Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color:
                                    Colors.grey.withOpacity(0.5), // Shadow color
                                spreadRadius: 5, // Spread radius
                                blurRadius: 7, // Blur radius
                                offset:
                                    Offset(0, 3), // Offset in x and y directions
                              ),
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          child: Column(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                          currentSong.albumArtImagePath,height: 56,),
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        currentSong.songName,
                                        style: TextStyle(
                                          color: Theme.of(context).colorScheme.primary,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                        ),
                                      ),
                                      Text(currentSong.artistsName,style: TextStyle(color: Theme.of(context).colorScheme.primary,),),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: value.pauseOrResume,
                                    icon: Icon(value.isPlaying
                                        ? Icons.pause
                                        : Icons.play_arrow, color: Theme.of(context).colorScheme.primary,),
                                  ),
                                  IconButton(
                                    onPressed: (){
                                      setState(() {
                                        sngProvider.issActive=false;
                                      });
                                    },
                                    icon: Icon(Icons.cancel,color:Theme.of(context).colorScheme.primary ,),
                                  ),
                                ],
                              ),
                              LinearProgressIndicator(

                                value: value.currentDuration.inSeconds.toDouble() /
                                    value.totalDuration.inSeconds.toDouble(),
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.green),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ]);
          }),
        );
      },
    );
  }
}
