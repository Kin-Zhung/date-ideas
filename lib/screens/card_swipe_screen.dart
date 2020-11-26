import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/screens/add_screen.dart';
import 'package:dates2share/widgets/appDrawer.dart';
import 'package:dates2share/widgets/ideaList.dart';
import 'package:dates2share/widgets/sm_detail_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'package:provider/provider.dart';

class CardSwipe extends StatefulWidget {
  @override
  _CardSwipeState createState() => _CardSwipeState();
}

class _CardSwipeState extends State<CardSwipe> {
  //var _isInit = true;
  bool _isloading = true;
    //  Future<void>_refreshIdea(BuildContext context)async{
    //   await Provider.of<Date_Idea_provider>(context).getIdea();
    // }

  @override
  void initState() {
    // TODO: implement initState
    Future.delayed(Duration.zero).then((_) {
      Provider.of<Date_Idea_provider>(context, listen: false)
          .getIdea()
          .then((value) {
        setState(() {
          _isloading = false;
        });
        ;
      });
    });
  }

  // void didChangeDependencies() {
  //   // TODO: implement didChangeDependencies
  //   if (_isInit) {
  //     Provider.of<Date_Idea_provider>(context).getIdea();
  //   }
  //   _isInit = false;
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    CardController controller;
    // final providerIdea = Provider.of<Date_Idea_provider>(context, listen: true);

    return new Scaffold(
        appBar: AppBar(
          title: Text('Date Idea'),
        ),
        drawer: AppDrawer(),
        body: 
    _isloading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : IdeaList(),
        );
  }
  
}
