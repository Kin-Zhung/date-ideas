import 'package:dates2share/providers/auth.dart';
import 'package:dates2share/screens/add_screen.dart';
import 'package:dates2share/widgets/sm_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import '../providers/date_idea_provider.dart';
import 'package:provider/provider.dart';
import 'idea_card.dart';

class IdeaList extends StatelessWidget {
  Future<void> _refreshIdea(BuildContext context) async {
    await Provider.of<Date_Idea_provider>(context).getIdea();
  }

  @override
  Widget build(BuildContext context) {
    final loadIdea = Provider.of<Date_Idea_provider>(context);

    CardController controller;
    return RefreshIndicator(
      onRefresh: () => _refreshIdea(context),
      child: Column(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.8,
          child: TinderSwapCard(
            swipeUp: true,
            swipeDown: true,
            orientation: AmassOrientation.BOTTOM,
            totalNum: loadIdea.dateideas.length,
            stackNum: 3,
            swipeEdge: 4.0,
            maxWidth: MediaQuery.of(context).size.width * 0.95,
            maxHeight: MediaQuery.of(context).size.width * 1.21,
            minWidth: MediaQuery.of(context).size.width * 0.8,
            minHeight: MediaQuery.of(context).size.width * 1.2,
            cardBuilder: (context, index) => Card(
              child: SM_Detail_Card(loadIdea.dateideas[index], controller),
            ),
            cardController: controller = CardController(),
            swipeUpdateCallback: (DragUpdateDetails details, Alignment align) {
              /// Get swiping card's alignment
              if (align.x < 0) {
                //card swipe left
              } else if (align.x > 0) {
                //Card is RIGHT swiping
                print(loadIdea.dateideas[0].id);
              }
            },
            swipeCompleteCallback:
                (CardSwipeOrientation orientation, int index) {
              if (orientation == CardSwipeOrientation.RIGHT) {
                loadIdea.likeIdea(loadIdea.dateideas[index].id,
                    loadIdea.dateideas[index],);
                print(loadIdea.dateideas[index].id);
              } else if (orientation == CardSwipeOrientation.LEFT) {
                loadIdea.likeIdea(loadIdea.dateideas[index].id,
                    loadIdea.dateideas[index],);
                print(loadIdea.dateideas[index].id);
              }
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // InkWell(
              //   onTap: () {
              //     controller.triggerLeft();
              //     loadIdea.dislikeIdea(
              //         loadIdea.dateideas[0].id, loadIdea.dateideas[0].dislikes);

              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.3,
              //     decoration: BoxDecoration(
              //       color: Colors.red,
              //       border: Border.all(color: Colors.red),
              //       borderRadius: BorderRadius.circular(40),
              //     ),
              //     child: Icon(
              //       IconData(58535, fontFamily: 'MaterialIcons'),
              //     ),
              //   ),
              // ),
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(AddDateIdea.routeName);
                },
                child: Container(
                    margin: EdgeInsets.only(right: 10, left: 10),
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: Center(
                        child: Text(
                      'Add',
                      style: TextStyle(fontSize: 20),
                    ))),
              ),
              // InkWell(
              //   onTap: () {
              //     controller.triggerRight();
              //     loadIdea.likeIdea(
              //         loadIdea.dateideas[0].id, loadIdea.dateideas[0].dislikes);
              //     print(loadIdea.dateideas[0].id);
              //   },
              //   child: Container(
              //     width: MediaQuery.of(context).size.width * 0.3,
              //     decoration: BoxDecoration(
              //       color: Colors.green,
              //       border: Border.all(color: Colors.green),
              //       borderRadius: BorderRadius.circular(40),
              //     ),
              //     child: Icon(
              //       IconData(58537, fontFamily: 'MaterialIcons'),
              //     ),
              //   ),
              // ),
            ],
          ),
        )
      ]),
    );
  }
}
