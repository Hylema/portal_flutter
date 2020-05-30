import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/likeNews/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class LikesSeenWidget extends StatelessWidget {

  final getIt = GetIt.instance;

  final Color color;
  final NewsModel news;
  final Function likeFunc;
  final bool dense;

  LikesSeenWidget({@required this.news, @required this.color, this.likeFunc, this.dense = false});

  @override
  Widget build(BuildContext context) {

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.remove_red_eye,
                  size: dense ? 12 : 30,
                  color: Colors.grey[300],
                ),
                Text(
                  ' ${news.viewedCount}',
                  style: TextStyle(
                    fontSize: dense ? 12 : 15,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: dense ? 10 : 20),
          Container(
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(
                    !news.isLike() ? Icons.favorite_border : Icons.favorite,
                    size: dense ? 16 : 30,
                    color: !news.isLike() ? Colors.grey[300] : Color.fromRGBO(238, 0, 38, 1),
                  ),
                  Text(
                    ' ${news.likesCount}',
                    style: TextStyle(
                      fontSize: dense ? 12 : 15,
                      color: color,
                    ),
                  ),
                ],
              ),
              onTap: () => likeFunc == null ? null : likeFunc(news.id, news.guid),
            ),
          )
        ],
      ),
    );

//    return Container(
//      child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceAround,
//        children: <Widget>[
//          Container(
//            child: Row(
//              children: <Widget>[
//                Icon(
//                  Icons.remove_red_eye,
//                  size: 16,
//                  color: color,
//                ),
//                Text(
//                  ' $viewedCount',
//                  style: TextStyle(
//                    fontSize: 12,
//                    color: color
//                  ),
//                ),
//              ],
//            ),
//          ),
//          Padding(
//            padding: EdgeInsets.only(right: 10),
//          ),
//          Container(
//            child: GestureDetector(
//              child: Row(
//                children: <Widget>[
//                  Icon(
//                    Icons.favorite_border,
//                    size: 16,
//                    color: color,
//                  ),
//                  Text(
//                    ' $likesCount',
//                    style: TextStyle(
//                      fontSize: 12,
//                      color: color
//                    ),
//                  ),
//                ],
//              ),
//              onTap: (){
//                print('Запись понравилась');
//              },
//            ),
//          ),
//        ],
//      ),
//    );
  }
}