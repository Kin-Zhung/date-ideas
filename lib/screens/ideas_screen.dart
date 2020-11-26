import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/widgets/ideaList.dart';
import 'package:flutter/material.dart';
import '../providers/date_idea.dart';
import '../widgets/idea_card.dart';
import 'package:provider/provider.dart';

class IdeaList_Screen extends StatefulWidget {
  @override
  _IdeaList_ScreenState createState() => _IdeaList_ScreenState();
}

class _IdeaList_ScreenState extends State<IdeaList_Screen> {
  final List<Dateidea> testidea = [];
  bool _showFavourite = false;
  @override
  Widget build(BuildContext context) {
    //final dateprovider = Provider.of<Date_Idea_provider>(context);
    //List<Dateidea> testidea;
    // final testidea = dateprovider.dateideas;
    return Scaffold(
        appBar: AppBar(
          title: Text('Operations'),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (int selectedValue) {
                  setState(() {
                    if (selectedValue == 0) {
                      _showFavourite = true;
                    } else {
                      _showFavourite = false;
                    }
                  });
                },
                icon: Icon(Icons.more_vert),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text('Favourite'),
                        value: 0,
                      ),
                      PopupMenuItem(
                        child: Text('All'),
                        value: 1,
                      ),
                    ])
          ],
        ),
        // body: IdeaList(_showFavourite)
        // ListView.builder(
        //   padding: const EdgeInsets.all(10.0),
        //   itemCount: testidea.length,
        //   itemBuilder: (context, index) => ChangeNotifierProvider(
        //     create: (context) => testidea[index],
        //     child: IdeaCard(),
        //   ),
        // ),
        );
  }
}

class Dataidea {}
