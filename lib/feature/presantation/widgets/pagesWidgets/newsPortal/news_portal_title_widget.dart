import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_image_network_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';

class NewsPortalTitle extends StatelessWidget {

  NewsPortalTitle({
    this.news,
    this.index = 0,
  }){
    assert(news != null);
  }
  final news;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
      child: FlexibleSpaceBar(
        background: Stack(
            children: <Widget>[
              ImageNetworkWidget(
                  path: news.slNewsCover,
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
                      const Color(0xC0000000),
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
                      child: DateTimeWidget(
                        dataTime: news.created,
                        color: Colors.white,
                      ),
                    ),
                    TitleWidget(
                      title: news.title,
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