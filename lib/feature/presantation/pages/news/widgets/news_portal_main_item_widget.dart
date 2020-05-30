import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information.dart';
import 'file:///C:/code/portal_flutter/lib/feature/presantation/pages/news/widgets/news_portal_image_network_widget.dart';
import 'file:///C:/code/portal_flutter/lib/feature/presantation/pages/news/widgets/news_portal_likes_seen_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';

class NewsPortalMainItem extends StatelessWidget {

  NewsPortalMainItem({
    this.news,
    this.index = 0,
    this.fromCard = false,
  }){
    assert(news != null);
  }
  final NewsModel news;
  final int index;
  final bool fromCard;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        !fromCard ? Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsPortalCardInformationPage(
                  index: index,
                  news: news,
                )
            )
        ) : null;
      },
      child: FlexibleSpaceBar(
        background: Stack(
            children: <Widget>[
              ImageNetworkWidget(
                  path: news.cover,
                  index: index
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0x00000000),
                      const Color(0xC0000000).withOpacity(0.7),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(15),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          DateTimeWidget(
                            dataTime: news.published,
                            color: Colors.white,
                          ),
                          !fromCard ? LikesSeenWidget(news: news, color: Colors.white, dense: true,) : Container()
                        ],
                      )
                    ),
                    Text(
                      news.title,
                      overflow: TextOverflow.fade,
                      maxLines: 3,
                      softWrap: true,
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }
}