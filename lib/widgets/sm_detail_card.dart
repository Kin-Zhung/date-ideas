import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/widgets/imgCarousel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

class SM_Detail_Card extends StatelessWidget {
  final Idea idea;
  final CardController controller;

  SM_Detail_Card(this.idea, this.controller);
  @override
  Widget build(BuildContext context) {
    final loadIdea = Provider.of<Date_Idea_provider>(context);
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [(idea.dislikes/(idea.dislikes+idea.likes)),0.1],
          colors: [
            const Color(0xffFF7C7C),
            const Color(0xff96FF7C),
          ],
        ),
      ),
      child: Column(
        children: [
          Container(
            height: 200,
            padding: EdgeInsets.all(10),
            child: ImgCarousel(idea.images),
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Text(
              idea.title,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              idea.location,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(bottom: 10),
            child: idea.price == 0
                ? Text(
                    'cost: FREE',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )
                : Text(
                    'cost: \$${idea.price}',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
          ),
          Container(
            height: 130,
            padding: EdgeInsets.all(8.0),
            child: SingleChildScrollView(child: Text(idea.detail)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  loadIdea.dislikeIdea(idea.id, idea);
                  controller.triggerLeft();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xffFF0000),
                    border: Border.all(color: Color(0xffFF0000)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        IconData(58535, fontFamily: 'MaterialIcons'),
                      ),
                      Text('${idea.dislikes}'),
                    ],
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  loadIdea.likeIdea(idea.id, idea);
                  controller.triggerRight();
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  decoration: BoxDecoration(
                    color: Color(0xff04FA00),
                    border: Border.all(color: Color(0xff04FA00)),
                    borderRadius: BorderRadius.circular(40),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(
                        IconData(58537, fontFamily: 'MaterialIcons'),
                      ),
                      Text('${idea.likes}'),
                    ],
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
