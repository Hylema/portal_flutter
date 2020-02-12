import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class VideosMainPageSwipeStackWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(bottom: 20),
      child: Swiper(
        autoplay: true,
        autoplayDelay: 7000,
        itemBuilder: (BuildContext context, int index) {
          return new Image.asset(
            "assets/images/video_test.jpg",
            fit: BoxFit.fill,
          );
        },
        itemCount: 10,
        itemWidth: MediaQuery.of(context).size.width / 1.2,
        viewportFraction: 0.8,
        layout: SwiperLayout.STACK,
      )
    );
  }
}
