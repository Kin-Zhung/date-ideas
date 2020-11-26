import 'dart:convert';
import 'dart:typed_data';

import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/date_idea.dart';
import 'package:dates2share/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'cetergories.dart';

class IdeaCard extends StatelessWidget {
  final Idea idea;
  IdeaCard(this.idea);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.20,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            Details_Screen.routeName,
            arguments: Idea(
                id: idea.id,
                title: idea.title,
                location: idea.location,
                price: idea.price,
                detail: idea.detail,
                images: idea.images,
                likes: idea.likes,
                dislikes: idea.dislikes),
          );
        },
        child: Card(
          elevation: 5,
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.4,
                child: _getImage(idea.images),
              ),
              Container(
                padding: EdgeInsets.all(10.0),
                width: MediaQuery.of(context).size.width * 0.5,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        idea.title,
                       
                      ),
                    ),
                    // Text(location),
                    // Text('cost: $cost'),
                    Container(
                      child: Text(idea.location),
                    ),
                    Container(
                      child: Text(
                        (idea.price == 0)
                            ? ('Price: Free')
                            : ('price: ${idea.price}'),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Icon(
                          IconData(58537, fontFamily: 'MaterialIcons'),
                        ),
                        Text('${idea.likes}'),
                        Icon(
                          IconData(58535, fontFamily: 'MaterialIcons'),
                        ),
                        Text('${idea.dislikes}'),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _getImage(List imgList) {
    Uint8List _bytesImage = base64Decode(imgList[0]);
    return Container(
        child: Image.memory(
      _bytesImage,
      fit: BoxFit.cover,
      width: double.infinity,
    ));
  }
}
