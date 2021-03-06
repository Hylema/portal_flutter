import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PhoneBookUsersPageShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int offset = 0;
    int time = 800;

    return SmartRefresherWidget(
      enableControlRefresh: true,
      enableControlLoad: false,
//      onRefresh: () => BlocProvider.of<BirthdayBloc>(context).add(UpdateBirthdayEvent()),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                color: Colors.grey[200],
                child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Shimmer.fromColors(
                        highlightColor: Colors.white,
                        baseColor: Colors.grey[300],
                        child: Container(
                          height: 30,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                        ),
                        period: Duration(milliseconds: time),
                      ),

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
          Container(
            height: 65,
            width: 65,
            padding: EdgeInsets.only(right: 15),
            child: CircleAvatar(),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 20,
                  color: Colors.grey,
                ),
                SizedBox(height: 10,),
                Container(
                  width: MediaQuery.of(context).size.width / 2,
                  height: 15,
                  color: Colors.grey,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
