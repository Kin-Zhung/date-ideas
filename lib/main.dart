import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/auth.dart';
import 'package:dates2share/providers/liked.dart';
import 'package:dates2share/screens/add_screen.dart';
import 'package:dates2share/screens/auth_screen.dart';
import 'package:dates2share/screens/card_swipe_screen.dart';
import 'package:dates2share/screens/details_screen.dart';
import 'package:dates2share/screens/dislike_screen.dart';
import 'package:dates2share/screens/ideas_screen.dart';
import 'package:dates2share/screens/liked_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'providers/date_idea_provider.dart';


  void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
        return MultiProvider(
          providers: [
            ChangeNotifierProvider.value(
          value: Auth(),
            ),
            // ignore: missing_required_param
            ChangeNotifierProxyProvider<Auth, Date_Idea_provider>(
              update: (context, auth, previousIdeas) => Date_Idea_provider(
                  auth.token,
                  previousIdeas == null ? [] : previousIdeas.dateideas,
                  auth.userId),
            ),
            ChangeNotifierProvider.value(
              value: LikedList(),
            )
          ],
          child: Consumer<Auth>(
            builder: (context, authData, _) => MaterialApp(
          debugShowCheckedModeBanner: false,

              title: 'Date Ideas',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: authData.isAuthenticated ? CardSwipe() : AuthScreen(),
              routes: {
                Details_Screen.routeName: (context) => Details_Screen(),
                AddDateIdea.routeName: (context) => AddDateIdea(),
                LikedScreen.routeName: (context) => LikedScreen(),
                DislikedScreen.routeName: (context) => DislikedScreen(),
               
          },
        ),
      ),
    );
  }
}
