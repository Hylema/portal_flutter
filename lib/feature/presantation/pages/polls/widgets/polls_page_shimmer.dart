import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:shimmer/shimmer.dart';
class PollsPageShimmer extends StatelessWidget {
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
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                    child: Shimmer.fromColors(
                      highlightColor: Colors.white,
                      baseColor: Colors.grey[300],
                      child: Container(
                        height: 10,
                        color: Colors.white,
                        width: MediaQuery.of(context).size.width,
                      ),
                      period: Duration(milliseconds: time),
                    )
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
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(
            color: Colors.grey[400],
          ))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 20,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: 10,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2,
                    height: 15,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

