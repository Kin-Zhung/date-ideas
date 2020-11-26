import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class Idea {
  String id;
  String title;
  String location;
  double price;
  String detail;
  List images;
  int likes;
  int dislikes;
  String creatorId;

  Idea({
    this.id,
    this.title,
    this.location,
    this.price,
    this.detail,
    this.images,
    this.likes = 0,
    this.dislikes = 0,
  });
}
