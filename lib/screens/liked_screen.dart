import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/widgets/appDrawer.dart';
import 'package:dates2share/widgets/idea_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class LikedScreen extends StatelessWidget {
  static const routeName = '/likes';
  @override
  Widget build(BuildContext context) {
    print('building orders');
    // final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Liked Ideas'),
      ),
      drawer: AppDrawer(),
      body: FutureBuilder(
        future: Provider.of<Date_Idea_provider>(context, listen: false).getLikedIdea(),
        builder: (ctx, dataSnapshot) {
          if (dataSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            if (dataSnapshot.error != null) {
              return Center(
                child: Text('An error occurred!'),
              );
            } else {
              return Consumer<Date_Idea_provider>(
                builder: (ctx, likedIdea, child) => ListView.builder(
                      itemCount: likedIdea.likedideas.length,
                      itemBuilder: (ctx, i) => IdeaCard(likedIdea.likedideas[i]),
                    ),
              );
            }
          }
        },
      ),
    );
  }
}