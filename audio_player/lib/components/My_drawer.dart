import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme/theme_provider.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        children: [
          DrawerHeader(
            child: Icon(
              Icons.music_note,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 25),
              child: ListView(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text("H O M E"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.person,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: Text("F A V O U R I T E S"),
                    onTap: () {
                      Navigator.pushNamed(context, '/fav');
                    },
                  ),

                ],
              ),
            ),
          ),
          ListTile(
            title: Container(
              padding: EdgeInsets.all(16),
              margin: EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Dark Mode",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  CupertinoSwitch(
                      value: Provider.of<ThemeProvider>(context, listen: false)
                          .isDarkMode,
                      onChanged: (value) =>
                          Provider.of<ThemeProvider>(context, listen: false)
                              .toggleTheme())
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
