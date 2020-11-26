import 'dart:core';
import 'package:dates2share/providers/date_idea.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class LikedList with ChangeNotifier {
  List<Dateidea> _likedList;
  List<Dateidea> _dislikedList;

  void liked(Dateidea dId) {
    _likedList.add(dId);
  }

  void disliked(Dateidea dId) {
    _dislikedList.add(dId);
  }
}
