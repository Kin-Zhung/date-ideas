import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:dates2share/model/idea.dart';
import 'package:dates2share/providers/auth.dart';
import 'package:dates2share/providers/date_idea_provider.dart';
import 'package:dates2share/widgets/appDrawer.dart';
import 'package:dates2share/widgets/chooseImage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';

class AddDateIdea extends StatefulWidget {
  AddDateIdea({
    Key key,
  }) : super(key: key);
  static const routeName = '/add-idea';
  @override
  _AddDateIdeaState createState() => _AddDateIdeaState();
}

class _AddDateIdeaState extends State<AddDateIdea> {
  List<Asset> listImages;
  final _form = GlobalKey<FormState>();
  var idea = new Idea();
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Date Idea'),
      ),drawer: AppDrawer(),
      body: Center( 
        child: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            :  InkWell(
          onTap:(){
        FocusScope.of(context).unfocus();    
          }  ,
                  child: Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Form(
              key: _form,
              child: ListView(
                children: <Widget>[
                  ChooseImage(cbfunction: getImages),
                  Container(
                    child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Title'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            idea.title = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter a title';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Location'),
                          textInputAction: TextInputAction.next,
                          onSaved: (value) {
                            idea.location = value;
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter a location';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Average Price'),
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            idea.price = double.parse(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'please enter a number!';
                            } else if (double.tryParse(value) == null) {
                              return 'please enter a valid 2 Digit numeric number!';
                            } else if (double.parse(value) < 0) {
                              return 'please enter a number greater or equal to 0!';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Details'),
                          textInputAction: TextInputAction.next,
                          maxLines: 3,
                          onSaved: (value) {
                            idea.detail = value;
                          },
                          validator: (value) {
                            if (value.length < 10) {
                              return 'please enter some more basic detail min 10 letter';
                            }
                            return null;
                          },
                        ),
                        InkWell(
                            onTap: () {
                              _saveForm(auth.token);
                            },
                            child: Container(
                              margin: EdgeInsets.only(top: 15),
                              // color: Colors.orange,
                              width: 200,
                              decoration: BoxDecoration(
                                color: Colors.orange,
                                border: Border.all(color: Colors.orange),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Text(
                                'Save',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 30,
                                ),
                              ),
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

//------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  void getImages(imgs) {
    setState(() {
      listImages = imgs;
      // for (int x = 0; x < listImages.length; x++) {
      //   print(x);
      // }
      // print(listImages);
    });
  }

  _convertImg(List<Asset> img) async {
    ByteData byteData;
    List<String> d = [];
    for (int x = 0; x < img.length; x++) {
      Asset a = img[x];
      byteData = await a.getByteData();
      if (byteData != null) {
        List<int> imgDatas = byteData.buffer.asUint8List();
        d.add(base64.encode(imgDatas));
      }
    }
    return d;
  }

  void _saveForm(String token) async {
    final pass = _form.currentState.validate();
    idea.images =  await _convertImg(listImages);
    //idea.images = listImages;
    setState(() {
      _isLoading = true;
    });
    if (pass) {
      _form.currentState.save();
      try {
        Provider.of<Date_Idea_provider>(context, listen: false).addIdea(idea,token);
      } catch (error) {
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An error Occured'),
                  content: Text(' ooops sorry something went wrong!'),
                  actions: <Widget>[
                    FlatButton(
                        child: Text('ok'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        })
                  ],
                ));
      } finally {
        setState(() {
          _isLoading = false;
        });
        Navigator.of(context).pop();
      }
    }
  }
}
