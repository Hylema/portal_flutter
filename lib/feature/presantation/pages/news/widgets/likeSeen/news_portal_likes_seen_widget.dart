import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/likeSeen/news_portal_like_seen_widger_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';

class LikesSeenWidget extends StatelessWidget{

  final getIt = GetIt.instance;

  final Color color;
  final NewsModel news;
  final Function likeFunc;
  final bool dense;

  LikesSeenWidget({@required this.news, @required this.color, this.likeFunc, this.dense = false});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsPortalLikeSeenWidgetViewModel>.reactive(
      builder: (context, model, child) => Container(
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
                    AnimatedCrossFade(
                      crossFadeState: model.actionIn ? (model.isLikeNow ? CrossFadeState.showFirst : CrossFadeState.showSecond) : (news.isLike()  ? CrossFadeState.showFirst : CrossFadeState.showSecond),
                      //alwaysIncludeSemantics: true,
                      duration: Duration(milliseconds: 200),
                      firstChild: Icon(
                        Icons.favorite,
                        size: dense ? 16 : 30,
                        color: Color.fromRGBO(238, 0, 38, 1),
                      ),
                      secondChild: Icon(
                        Icons.favorite_border,
                        size: dense ? 16 : 30,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      ' ${model.actionIn ? model.likeCount : news.likesCount}',
                      style: TextStyle(
                        fontSize: dense ? 12 : 15,
                        color: color,
                      ),
                    ),
                  ],
                ),
                onTap: () => likeFunc == null ? null : model.likeIt(),
              ),
            )
          ],
        ),
      ),
      viewModelBuilder: () => NewsPortalLikeSeenWidgetViewModel(
        likeFunc: likeFunc,
        news: news,
        newsBloc: BlocProvider.of<NewsPortalBloc>(context),
      ),
    );
  }
}