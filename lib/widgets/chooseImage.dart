import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'package:reorderables/reorderables.dart';
import 'package:flutter/services.dart';

class ChooseImage extends StatefulWidget {
  final cbfunction;
  ChooseImage({Key key, this.cbfunction}) : super(key: key);
  @override
  _ChooseImageState createState() => _ChooseImageState();
}

class _ChooseImageState extends State<ChooseImage> {
  List<Asset> listImages;
  List<Image> _imageList = List<Image>();
  List files = [];
  List<Asset> images = List<Asset>();
  String _error = 'No Error Dectected';
  List<Widget> _imgCard = List<Widget>();

  @override
  void initState() {
    super.initState();
  }

//<!--------------------------widget view---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->
  @override
  Widget build(BuildContext context) {
    // var wrap = ReorderableWrap(
    //     spacing: 3.0,
    //     runSpacing: 3.0,
    //     padding: const EdgeInsets.all(8),
    //     children: _imgCard,
    //     onReorder: _onReorder,
    //     onNoReorder: (int index) {
    //       //this callback is optional
    //       debugPrint(
    //           '${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
    //     },
    //     onReorderStarted: (int index) {
    //       //this callback is optional
    //       debugPrint(
    //           '${DateTime.now().toString().substring(5, 22)} reorder started: index:$index');
    //     });
    return Container(
      child: Column(
        children: [
          Container(
            // margin: EdgeInsets.all(8),
            // padding: EdgeInsets.all(10),
            // width: MediaQuery.of(context).size.width * 0.8,
            height: 200,
            // decoration: BoxDecoration(
            //   border: Border.all(color: Colors.blue),
            //   borderRadius: BorderRadius.circular(40.0),
            // ),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: ReorderableWrap(
                    spacing: 3.0,
                    runSpacing: 3.0,
                    padding: const EdgeInsets.all(8),
                    children: _imgCard,
                    onReorder: _onReorder,
                  ),
                ),
              ],
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              _showPicker(context);
            },
            child: Icon(Icons.add_a_photo),
          ),
        ],
      ),
    );
  }

//<!-----------functions------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

  Widget buildGridView() {
    return GridView.count(
      crossAxisCount: 3,
      children: List.generate(images.length, (index) {
        Asset asset = images[index];
        return AssetThumb(
          asset: asset,
          width: 100,
          height: 100,
        );
      }),
    );
  }

  Future<void> loadAssets() async {
    List<Asset> resultList = List<Asset>();
    String error = 'No Error Dectected';

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 6,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle: "Select 6 Image",
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    if (!mounted) return;

    setState(() {
      images = resultList;
      _error = error;
      _allImages(images);

      widget.cbfunction(resultList);
    });
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        loadAssets();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }

  _onReorder(int oldIndex, int newIndex) {
    setState(() {
      Widget row = _imgCard.removeAt(oldIndex);
      _imgCard.insert(newIndex, row);
    });
  }

  _allImages(List<Asset> images) {
    List<Widget> list = List<Widget>();
    for (var i = 0; i < images.length; i++) {
      Asset asset = images[i];

      list.add(
        Stack(
          key: UniqueKey(),
          children: [
            Container(
              child: AssetThumb(
                asset: asset,
                width: 100,
                height: 100,
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 20,
                height: 20,
                child: FloatingActionButton(
                  child: Text('X'),
                  backgroundColor: Colors.red,
                  onPressed: () {
                    _imgCard
                        .removeWhere((element) => _removeImage(element.key));
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }
    setState(() {
      _imgCard = list;
    });
    // _imgCard = list;
  }

  _removeImage(index) {
    setState(
      () {
        int remove;
        for (var x = 0; x < _imgCard.length; x++) {
          if (_imgCard[x].key == index) {
            remove = x;
          }
        }
        if (!remove.isNaN) {
          _imgCard.removeAt(remove);
        }
      },
    );
  }

  getImageFileFromAsset(String path) async {
    final file = File(path);
    return file;
  }


}
