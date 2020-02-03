import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/newsPortalCardInformation/news_portal_card_information_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/date_time_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_image_network_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/title_widget.dart';


class NewsPortalItems extends StatefulWidget {
  NewsPortalItems({
    this.news,
    this.index,
    this.vertical = false,
  }){
    assert(this.news != null);
    assert(this.index != null);
  }
  final news;
  final index;
  final bool vertical;

  @override
  NewsPortalItemsState createState() => NewsPortalItemsState();
}

class NewsPortalItemsState extends State<NewsPortalItems> {

  @override
  Widget build(BuildContext context) {
    final double _heightCard = 160;
    final _news = widget.news;
    final _index = widget.index;

    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 10, left: 10, right: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewsPortalCardInformationPage(
                    index: _index,
                    news: _news,
                  )
              )
          );
        },
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListBody(
            children: <Widget>[
              Container(
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
                  child: GestureDetector(
//                    onPanUpdate: (details){
//
//                        setState(() {
//                          flexImage = 11;
//                          flexText = 1;
//                        });
//
//                    },
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          //fit: FlexFit.tight,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0)
                            ),
                            child: ImageNetworkWidget(
                                path: _news['slNewsCover'],
                                index: _index
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  TitleWidget(
                                    titleSize: 15,
                                    title: _news['Title'],
                                    color: Colors.black,
                                    maxSymbol: 70,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Container(
                                        //padding: EdgeInsets.only(top: 10),
                                        child: DateTimeWidget(
                                          dataTime: _news['Created'],
                                          color: Colors.grey[600],
                                        ),
                                      ),
                                      Container(
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
                                                    ' 12',
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
                                      ),
                                    ],
                                  ),
                                ],
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}