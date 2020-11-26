import 'dart:core';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Dateidea with ChangeNotifier {
  String image;
  String name;
  String location;
  String detail;
  int cost;
  List catergories;
  int likes;
  int dislikes;
  bool isFavourite;
  bool liked;
  bool disliked;

  Dateidea(
      {@required String image,
      @required String name,
      @required String location,
      @required String detail,
      @required int cost,
      @required List catergories}) {
    this.image = image;
    this.name = name;
    this.location = location;
    this.detail = detail;
    this.cost = cost;
    this.catergories = catergories;
    this.likes = 0;
    this.dislikes = 0;
    this.isFavourite = false;
    this.liked = false;
    this.disliked = false;
  }
  void toggleFavourite() {
    isFavourite = !isFavourite;
    notifyListeners();
  }
}
