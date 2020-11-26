import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/date_idea.dart';
import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/widgets/cetergories.dart';
import 'package:dates2share/widgets/imgCarousel.dart';
import 'package:dates2share/widgets/imgs.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Details_Screen extends StatelessWidget {
  static const routeName = '/idea/detail';

  @override
  Widget build(BuildContext context) {
    final Idea idea = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text(idea.title),
      ),
      body: Card(
        elevation: 10,
        child: Container(
          height: MediaQuery.of(context).size.height * 1,
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.34,
                width: MediaQuery.of(context).size.width * 1,
                child: ImgCarousel(idea.images),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(idea.title, style: TextStyle(fontSize: 35),),
              ),
               Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(idea.location, style: TextStyle(fontSize: 20),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Cost: ${idea.price}',style: TextStyle(fontSize: 20),),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.27,
                padding: EdgeInsets.all(8.0),
                child: SingleChildScrollView(child: Text(idea.detail,style: TextStyle(fontSize: 20))),
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
        ),
      ),
    );
  }
}
