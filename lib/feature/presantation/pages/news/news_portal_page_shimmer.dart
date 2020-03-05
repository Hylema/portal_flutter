import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:shimmer/shimmer.dart';

class NewsPortalPageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SmartRefresherWidget(
      enableControlRefresh: true,
      enableControlLoad: false,
      pageKey: NEWS_PAGE_SHIMMER,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Shimmer.fromColors(
                highlightColor: Colors.white,
                baseColor: Colors.grey[300],
                child: Container(
                  height: 260,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey,
                ),
                period: Duration(milliseconds: time),
              ),
            ]),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              offset += 5;
              time = 800 + offset;

              return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Shimmer.fromColors(
                    highlightColor: Colors.white,
                    baseColor: Colors.grey[300],
                    child: ShimmerLayout(),
                    period: Duration(milliseconds: time),
                  ));
            }, childCount: 5),
          )
        ],
      ),
    );
  }
}


class ShimmerLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double containerWidth = 170;
    double containerHeight = 15;

    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.grey,
            width: 5
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 7.5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 170,
            width: 180,
            color: Colors.grey,
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  height: containerHeight,
                  width: containerWidth,
                  color: Colors.grey,
                ),
                SizedBox(height: 5),
                Container(
                  height: containerHeight,
                  width: containerWidth * 0.75,
                  color: Colors.grey,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
