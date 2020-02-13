import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class BirthdayMainPageSwipeWidget extends StatefulWidget {

  @override
  BirthdayMainPageSwipeWidgetState createState() => BirthdayMainPageSwipeWidgetState();
}

class BirthdayMainPageSwipeWidgetState extends State {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 0),
      child: Swiper(
          autoplay: true,
          autoplayDelay: 4000,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10.0,
                      spreadRadius: 0.5,
                      offset: Offset(
                        5.0, // horizontal, move right 10
                        5.0, // vertical, move down 10
                      ),
                    )
                  ],
                ),
                margin: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Container(
                      constraints: BoxConstraints(maxWidth: 130, maxHeight: 130),
                      child: Center(
                        child: Image.asset('assets/images/noPhoto.png', width: 70,),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                5.0, // horizontal, move right 10
                                5.0, // vertical, move down 10
                              ),
                            )
                          ],
                          border: Border.all(
                              color: Colors.white,
                              width: 6.0
                          )
                      ),
                    ),
                    Text(
                      'Шалайкин Глеб Николаевич',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'Сегодня',
                      style: TextStyle(
                          color: Colors.grey[700],
                          fontSize: 11
                      ),
                    ),
                  ],
                )
            );
          },
          itemCount: 10,
          viewportFraction: 0.5
      ),
      height: 300,
    );
  }
}