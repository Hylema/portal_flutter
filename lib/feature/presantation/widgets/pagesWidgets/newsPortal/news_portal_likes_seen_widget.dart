import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class LikesSeen extends StatefulWidget {
  LikesSeen({this.id}){
    assert(id != null);
  }
  final id;

  @override
  LikesSeenState createState() => LikesSeenState();
}

class LikesSeenState extends State<LikesSeen> {

  @override
  void initState() {
//    context.bloc<NewsPopularityBloc>().add(GetNewsPopularityEvent(id: widget.id));

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.remove_red_eye,
                  size: 16,
                  color: Colors.grey,
                ),
                Text(
                  ' 0',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Container(
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Text(
                    ' 1',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onTap: (){
                print('Запись понравилась');
              },
            ),
          ),
        ],
      ),
    );
//    return BlocBuilder<NewsPopularityBloc, NewsPopularityState>(
//      builder: (context, state) {
//        if(state is LoadedNewsPopularity){
//
//          int _likes = state.model.popularity['likes'].length;
//          int _seen = state.model.popularity['seen'].length;
//
//          return Container(
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceBetween,
//              children: <Widget>[
//                Container(
//                  child: Row(
//                    children: <Widget>[
//                      Icon(
//                        Icons.remove_red_eye,
//                        size: 16,
//                        color: Colors.grey,
//                      ),
//                      Text(
//                        ' $_seen',
//                        style: TextStyle(
//                          fontSize: 12,
//                        ),
//                      ),
//                    ],
//                  ),
//                ),
//                Padding(
//                  padding: EdgeInsets.only(right: 10),
//                ),
//                Container(
//                  child: GestureDetector(
//                    child: Row(
//                      children: <Widget>[
//                        Icon(
//                          Icons.favorite_border,
//                          size: 16,
//                          color: Colors.grey,
//                        ),
//                        Text(
//                          ' $_likes',
//                          style: TextStyle(
//                            fontSize: 12,
//                          ),
//                        ),
//                      ],
//                    ),
//                    onTap: (){
//                      print('Запись понравилась');
//                    },
//                  ),
//                ),
//              ],
//            ),
//          );
//        } else {
//          return Container();
//        }
//      },
//    );
  }
}