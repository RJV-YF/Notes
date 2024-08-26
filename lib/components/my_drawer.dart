import 'package:flutter/material.dart';
import 'package:notes/components/my_drawer_tile.dart';
import 'package:notes/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Container(
            child: Icon(
              Icons.note,
              color: Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Divider(
            color: Theme.of(context).colorScheme.secondary,
          ),
          const SizedBox(
            height: 50,
          ),
          MyDrawerTile(
              title: "Notes",
              leading: Icon(
                Icons.home,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () {
                Navigator.pop(context);
              }),
          MyDrawerTile(
              title: "Settings",
              leading: Icon(
                Icons.settings,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              })
        ],
      ),
    );
  }
}
