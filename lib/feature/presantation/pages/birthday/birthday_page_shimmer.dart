import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:shimmer/shimmer.dart';

class BirthdayPageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SmartRefresherWidget(
      enableControlRefresh: true,
      enableControlLoad: false,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.grey[200],
                child: Padding(
                  padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                  child: Text(
                    'Сегодня',
                    style: TextStyle(
                        color: Color.fromRGBO(119, 134, 147, 1)
                    ),
                  ),
                ),
              ),
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
              }, childCount: 10)
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
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey[400],
          ))
      ),
      child: Row(
        children: <Widget>[
          Container(
            height: 65,
            width: 65,
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 250,
                height: 20,
                color: Colors.grey,
              ),
              SizedBox(height: 10,),
              Container(
                width: 150,
                height: 15,
                color: Colors.grey,
              ),
            ],
          )
        ],
      ),
    );
  }
}
