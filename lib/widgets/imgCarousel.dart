import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

// final List<String> list = [
//   'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
//   'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
//   'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
//   'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
//   'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
// ];

class ImgCarousel extends StatefulWidget {
  final List listImage;

  ImgCarousel(this.listImage);

  @override
  _ImgCarouselState createState() => _ImgCarouselState();
}

class _ImgCarouselState extends State<ImgCarousel> {
  final CarouselController _controller = CarouselController();
  int _current = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> list = _getImages(widget.listImage);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: CarouselSlider(
              items: list,
              options: CarouselOptions(
                  enlargeCenterPage: false,
                  viewportFraction: 1,
                  // aspectRatio: 1.0,
                  // enlargeCenterPage: true,
                  // height: 200,
                  //autoPlay: true,
                  // autoPlayInterval: Duration(seconds: 1),
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    },);
                  },),
              carouselController: _controller,
            ),
          ),
          Positioned(
            right: 0,
            left: 0,
            bottom: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: list.map((url) {
                int index = list.indexOf(url);
                return InkWell(
                  onTap: () => _controller.animateToPage(list.indexOf(url)),
                  child: Container(
                    width: 18.0,
                    height: 18.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _current == index
                          ? Color.fromRGBO(255, 255, 255, 0.9)
                          : Color.fromRGBO(100, 150, 250, 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

List<Widget> _getImages(List imgList) {
  List<Widget> l = [];
  for (int x = 0; x < imgList.length; x++) {
    Uint8List _bytesImage = base64Decode(imgList[x]);
    l.add(
      Container(
          child: Image.memory(
        _bytesImage,
        gaplessPlayback: true,
        fit: BoxFit.cover,
        width: double.infinity,
      )
          // AssetThumb(
          //   asset: imgList[x],
          //   height: 100,
          //   width: 100,
          // ),
          ),
    );
  }
  return l;
}

// final List<Widget> imageSliders = list
//     .map(
//       (item) => Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: NetworkImage(item),
//             fit: BoxFit.cover,
//           ),
//         ),
//         // child: Image.network(item),
//         // margin: EdgeInsets.all(5.0),
//         // child: ClipRRect(
//         //     borderRadius: BorderRadius.all(Radius.circular(5.0)),
//         //     child: Stack(
//         //       children: <Widget>[
//         //         Image.network(item),
//         //         Positioned(
//         //           bottom: 0.0,
//         //           left: 0.0,
//         //           right: 0.0,
//         //           child: Container(
//         //               decoration: BoxDecoration(
//         //                 gradient: LinearGradient(
//         //                   colors: [
//         //                     Color.fromARGB(200, 0, 0, 0),
//         //                     Color.fromARGB(0, 0, 0, 0)
//         //                   ],
//         //                   begin: Alignment.bottomCenter,
//         //                   end: Alignment.topCenter,
//         //                 ),
//         //               ),
//         //               padding:
//         //                   EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//         //               child: Text(
//         //                 'No. ',
//         //                 style: TextStyle(
//         //                   color: Colors.white,
//         //                   fontSize: 20.0,
//         //                   fontWeight: FontWeight.bold,
//         //                 ),
//         //               ),
//         //               ),
//         //         ),
//         //       ],
//         //     )),
//       ),
//     )
//     .toList();
