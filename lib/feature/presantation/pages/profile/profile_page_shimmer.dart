import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:shimmer/shimmer.dart';



class ProfilePageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SmartRefresherWidget(
      enableControlLoad: false,
      enableControlRefresh: true,
      pageKey: PROFILE_PAGE_SHIMMER,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Stack(
                alignment: Alignment.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: Shimmer.fromColors(
                          highlightColor: Colors.white,
                          baseColor: Colors.grey[300],
                          child: Stack(
                            children: <Widget>[
                              Container(
                                height: 260,
                                width: MediaQuery.of(context).size.width,
                                color: Colors.grey,
                              ),

                            ],
                          ),
                          period: Duration(milliseconds: time),
                        ),
                      )
                    ],
                  ),
                  Positioned(
                    top: 170.0,
                    child: Container(
                      child: Container(
                        height: 150.0,
                        width: 150.0,
                        child: Shimmer.fromColors(
                          highlightColor: Colors.white,
                          baseColor: Colors.grey[300],
                          child: Container(
                            height: 150.0,
                            width: 150.0,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    blurRadius: 10.0,
                                    spreadRadius: 0.5,
                                    offset: Offset(
                                      10.0, // horizontal, move right 10
                                      10.0, // vertical, move down 10
                                    ),
                                  )
                                ],
                                border: Border.all(
                                    color: Colors.white,
                                    width: 6.0
                                )
                            ),
                          ),
                          period: Duration(milliseconds: time),
                        ),
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
                                10.0, // horizontal, move right 10
                                10.0, // vertical, move down 10
                              ),
                            )
                          ],
                          border: Border.all(
                              color: Colors.white,
                              width: 6.0
                          )
                      ),
                    ),
                  ),
                ],
              ),
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 100),
                    Container(
                      width: 300,
                      height: 30,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 10),
                    Container(
                      width: 170,
                      height: 25,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 30),
                  ],
                ),
                period: Duration(milliseconds: time),
              )
            ]),
          ),
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey[300],
                      child: ShimmerLayout(),
                      period: Duration(milliseconds: time),
                    )
                );
              }, childCount: 5)
          ),
        ],
      ),
    );
  }
}

class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 300,
            height: 20,
            color: Colors.grey,
          ),
          SizedBox(height: 10),
          Container(
            width: 170,
            height: 15,
            color: Colors.grey,
          ),
          SizedBox(height: 20),
          Container(
            height: 5,
            color: Colors.grey,
          ),
          SizedBox(height: 5),
        ],
      ),
    );
  }
}
