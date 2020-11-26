import 'package:dates2share/providers/auth.dart';
import 'package:dates2share/screens/add_screen.dart';
import 'package:dates2share/screens/dislike_screen.dart';
import 'package:dates2share/screens/liked_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('options'),
            automaticallyImplyLeading: false,
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            leading: Icon(IconData(58727, fontFamily: 'MaterialIcons')),
            title: Text('Add Idea'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AddDateIdea.routeName);
            },
          ),
          ListTile(
            leading: Icon(IconData(58537, fontFamily: 'MaterialIcons')),
            title: Text('Liked'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(LikedScreen.routeName);
            },
          ),
          ListTile(
            leading: Icon(IconData(58535, fontFamily: 'MaterialIcons')),
            title: Text('Disliked'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(DislikedScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
