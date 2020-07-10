import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:shimmer/shimmer.dart';

class ListTileShimmer extends StatelessWidget {
  final bool enableControlRefresh;
  final bool enableControlLoad;
  final Widget trailing;

  ListTileShimmer({
    this.enableControlRefresh = false,
    this.enableControlLoad = false,
    this.trailing
  });

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlRefresh: enableControlRefresh,
      enableControlLoad: enableControlLoad,
//      onRefresh: () => BlocProvider.of<BirthdayBloc>(context).add(UpdateBirthdayEvent()),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                return Shimmer.fromColors(
                  highlightColor: Colors.white,
                  baseColor: Colors.grey[300],
                  child: Column(
                    children: <Widget>[
                      ListTile(
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 200,
                                height: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Text(''),
                            )
                          ],
                        ),
                        subtitle: Row(
                          children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Container(
                                width: 100,
                                height: 15,
                                color: Colors.grey,
                              ),
                            ),
                            Expanded(
                              child: Text(''),
                            )
                          ],
                        ),
                        trailing: trailing,
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20),
                        decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(
                              width: 0.8,
                              color: Colors.grey[400],
                            ))
                        ),
                      ),
                    ],
                  ),
                  period: Duration(milliseconds: 800),
                );
              }, childCount: 10)
          ),
        ],
      ),
    );
  }
}

