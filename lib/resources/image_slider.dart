import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screen_scaler/flutter_screen_scaler.dart';

class ImageSlider extends StatefulWidget {
  List<String> imgList;

  ImageSlider({Key key, this.imgList});
  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    ScreenScaler scaler = ScreenScaler()..init(context);
    return Column(children: [
      Container(
        child: CarouselSlider(
          items: widget.imgList
              .map((item) => Container(
                    width: scaler.getWidth(80),
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) => Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: scaler.getHeight(30),
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              aspectRatio: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(scaler.getHeight(1)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (int i = 0; i < widget.imgList.length; i++)
              _current == i
                  ? pageIndexIndicator(true)
                  : pageIndexIndicator(false)
          ],
        ),
      ),
    ]);
  }
}

Widget pageIndexIndicator(bool isCurrentPage) {
  ScreenScaler scaler = ScreenScaler();

  return Container(
    margin: EdgeInsets.symmetric(horizontal: scaler.getWidth(.1)),
    height: scaler.getWidth(.4),
    width: scaler.getWidth(.4),
    decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isCurrentPage ? Color(0xff6747CD) : Color(0xffE5E5E5)),
  );
}
