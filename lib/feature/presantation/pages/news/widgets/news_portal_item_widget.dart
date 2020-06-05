import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/likeSeen/news_portal_likes_seen_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_image_network_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';

class NewsPortalItem extends StatelessWidget {

  final NewsModel news;
  final int index;
  final bool vertical;

  int flexImage = 5;
  int flexBody = 7;

  NewsPortalItem({
    @required this.news,
    @required this.index,
    this.vertical = false,
  }){
    assert(this.news != null);
    assert(this.index != null);
    if(vertical){
      flexBody = 6;
      flexImage = 6;
    }
  }

  final double _heightCard = 160;

  @override
  Widget build(BuildContext context) {
    final _childrenWidgets = <Widget>[
      Expanded(
        flex: flexImage,
        child: ClipRRect(
          borderRadius: !vertical ? BorderRadius.only(
              topLeft: Radius.circular(10.0),
              bottomLeft: Radius.circular(10.0)
          )
              : BorderRadius.only(
              topLeft: Radius.circular(10.0),
              topRight: Radius.circular(10.0)
          ),
          child: ImageNetworkWidget(
              path: news.cover,
              index: index
          ),
        ),
      ),
      Expanded(
        flex: flexBody,
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  news.title,
                  overflow: TextOverflow.fade,
                  maxLines: 3,
                  softWrap: true,
                  style: TextStyle(fontSize: 15, color: Colors.black),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    DateTimeWidget(
                      dataTime: news.published,
                      color: Colors.grey[600],
                    ),
                    LikesSeenWidget(news: news, color: Colors.grey, dense: true,)
                  ],
                ),
              ],
            )
        ),
      ),
    ];

    return Container(
      height: 200,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsPortalCardInformationPage(
                    index: index,
                    news: news,
                  )
              )
          );
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 10.0,
                  spreadRadius: 1,
                  offset: Offset(
                    1.0, // horizontal, move right 10
                    1.0, // vertical, move down 10
                  ),
                ),
              ],
            ),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white
              ),
              height: _heightCard,
              child: vertical == true ? Column(
                children: _childrenWidgets
              ) : Row(children: _childrenWidgets),
            ),
          ),
        ),
      ),
    );
  }
}
