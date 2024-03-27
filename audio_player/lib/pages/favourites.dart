import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'favourites_provider.dart';

class FavPage extends StatefulWidget {
  FavPage({super.key});

  @override
  State<FavPage> createState() => _FavPageState();
}

class _FavPageState extends State<FavPage> {
  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavProvider>(context);
    final favs = favProvider.favs;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //title
            Center(child: Text("F A V O U R I T E S")),
            IconButton(
                onPressed: () {
                  setState(() {
                    favProvider.clearFavourite();
                  });
                },
                icon: Icon(Icons.cancel))
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: ListView.builder(
          itemCount: favProvider.favs.length,
          itemBuilder: (context, index) {
            final fav = favs[index];
            return ListTile(
              title: Text(fav),
              trailing: IconButton(
                onPressed: () {
                  favProvider.toggleFavourite(fav);
                },
                icon: Icon(Icons.remove),
              ),
            );
          }),
    );
  }
}
