import 'package:flutter/material.dart';

class Catergories extends StatelessWidget {
  final List catergories;

  Catergories(this.catergories);
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      // padding: EdgeInsets.all(0),
      // height: MediaQuery.of(context).size.height * 0.15,
      child: Wrap(
        children: <Widget>[
          for (var c in catergories)
            Theme(
               data: ThemeData(canvasColor: Colors.transparent),
                          child: Chip(
                //backgroundColor: Colors.transparent,
                label: Text(c),
              ),
            )
        ],
      ),
    );
  }
}
