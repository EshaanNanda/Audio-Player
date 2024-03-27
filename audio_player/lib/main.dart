import 'package:audio_player/models/playlist_provider.dart';
import 'package:audio_player/pages/favourites.dart';
import 'package:audio_player/pages/favourites_provider.dart';
import 'package:audio_player/pages/home_page.dart';
import 'package:audio_player/pages/my_settings.dart';
import 'package:audio_player/pages/songpage.dart';
import 'package:audio_player/theme/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context)=>FavProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          initialRoute: '/home',
          routes: {
            '/home': (context) => HomePage(),
            //'/settings': (context) => SettingsPage(),
            '/song':(context)=>SongPage(),
            '/fav':(context)=>FavPage()
          },
          home: HomePage(),
          debugShowCheckedModeBanner: false,
          theme: themeProvider.themeData,
        );
      },
    );
  }
}
