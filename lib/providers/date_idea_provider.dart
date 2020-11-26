import 'dart:convert';
import 'dart:typed_data';

import 'package:dates2share/model/idea.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multi_image_picker/multi_image_picker.dart';
import 'date_idea.dart';
import 'package:image_picker/image_picker.dart';

class Date_Idea_provider with ChangeNotifier {
  List<Idea> _dateIdeas = [];
  List<Idea> _likedIdeas = [];
  List<Idea> _dislikedIdeas = [];
  List<Idea> _createdIdeas = [];

  final String authToken;
  final String userId;
  Date_Idea_provider(this.authToken, this._dateIdeas, this.userId);

  Future<void> getIdea() async {
    final url =
        'https://dateshare-96727.firebaseio.com/ideas.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Idea> loadIdea = [];
      data.forEach((ideaId, ideaData) {
        loadIdea.add(
          Idea(
            id: ideaId,
            title: ideaData['title'],
            location: ideaData['location'],
            price: ideaData['price'],
            detail: ideaData['detail'],
            images: ideaData['images'],
            likes: ideaData['likes'],
            dislikes: ideaData['dislikes'],
          ),
        );
      });
      _dateIdeas = loadIdea;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getLikedIdea() async {
    print('https://dateshare-96727.firebaseio.com/likes/$userId.json?auth=$authToken');
    final url =
        'https://dateshare-96727.firebaseio.com/likes/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Idea> loadIdea = [];
      data.forEach((ideaId, ideaData) {
        loadIdea.add(
          Idea(
            id: ideaId,
            title: ideaData['title'],
            location: ideaData['location'],
            price: ideaData['price'],
            detail: ideaData['detail'],
            images: ideaData['images'],
            likes: ideaData['likes'],
            dislikes: ideaData['dislikes'],
          ),
        );
      });
      _likedIdeas = loadIdea;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> getdislikedIdea() async {
    final url =
        'https://dateshare-96727.firebaseio.com/dislikes/$userId.json?auth=$authToken';
    try {
      final response = await http.get(url);
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<Idea> loadIdea = [];
      data.forEach((ideaId, ideaData) {
        loadIdea.add(
          Idea(
            id: ideaId,
            title: ideaData['title'],
            location: ideaData['location'],
            price: ideaData['price'],
            detail: ideaData['detail'],
            images: ideaData['images'],
            likes: ideaData['likes'],
            dislikes: ideaData['dislikes'],
          ),
        );
      });
      _dislikedIdeas = loadIdea;
      notifyListeners();
      print(json.decode(response.body));
    } catch (error) {
      throw (error);
    }
  }

  Future<void> addIdea(Idea idea, String token) async {
    final url =
        'https://dateshare-96727.firebaseio.com/ideas.json?auth=$authToken';
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'title': idea.title,
            'location': idea.location,
            'price': idea.price,
            'detail': idea.detail,
            'images': idea.images,
            'likes': 0,
            'dislikes': 0,
            'creatorId': userId,
          },
        ),
      );
      final newidea = new Idea(
          id: json.decode(response.body)['name'],
          title: idea.title,
          location: idea.location,
          price: idea.price,
          detail: idea.detail,
          images: idea.images,
          likes: 0,
          dislikes: 0);
      print('adding to list');
      _dateIdeas.insert(0, newidea);
      notifyListeners();
    } catch (error) {
      print(error);
      throw error;
    }
  }

  Future<ByteData> getbtye(Asset asset) async {
    return await asset.getByteData();
  }

  List<Idea> get dateideas {
    return [..._dateIdeas];
  }

  List<Idea> get likedideas {
    return [..._likedIdeas];
  }

  List<Idea> get dislikedideas {
    return [..._dislikedIdeas];
  }

  List<Idea> get createdideas {
    return [..._createdIdeas];
  }

  Future<void> likeIdea(String id, Idea idea) async {
    int likes = idea.likes;
    likes++;
    print(likes);
    final url = 'https://dateshare-96727.firebaseio.com/ideas/$id.json';
    http.patch(
      url,
      body: json.encode(
        {'likes': likes},
      ),
    );
    final url2 =
        'https://dateshare-96727.firebaseio.com/likes/$userId.json?auth=$authToken';
    http.post(
      url2,
      body: json.encode(
        {
          'title': idea.title,
          'location': idea.location,
          'price': idea.price,
          'detail': idea.detail,
          'images': idea.images,
          'likes': idea.likes,
          'dislikes': idea.dislikes,
        },
      ),
    );
  }

  Future<void> dislikeIdea(String id, Idea idea) async {
    int dislikes = idea.dislikes;
    dislikes++;
    final url = 'https://dateshare-96727.firebaseio.com/ideas/$id.json';
    http.patch(
      url,
      body: json.encode(
        {'dislikes': dislikes},
      ),
    );
    final url2 =
        'https://dateshare-96727.firebaseio.com/dislikes/$userId.json?auth=$authToken';
    http.post(
      url2,
      body: json.encode(
        {
          'title': idea.title,
          'location': idea.location,
          'price': idea.price,
          'detail': idea.detail,
          'images': idea.images,
          'likes': idea.likes,
          'dislikes': idea.dislikes,
        },
      ),
    );
  }

  Future<void> removeIdea(String id) async {
    final url = 'https://dateshare-96727.firebaseio.com/ideas/$id.json';
    http.delete(
      url,
    );
  }
}
