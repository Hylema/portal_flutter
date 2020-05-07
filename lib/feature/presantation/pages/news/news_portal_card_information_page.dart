import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

NewsModel _news;
int _index;

class NewsPortalCardInformationPage extends StatefulWidget {
  NewsPortalCardInformationPage({
    news,
    index,
  }){
    assert(news != null);
    assert(index != null);

    _news = news;
    _index = index;
  }

  @override
  State<StatefulWidget> createState() => NewsPortalCardInformationPageState();
}

class NewsPortalCardInformationPageState extends State {

  ScrollController _scrollController = new ScrollController();
  bool _show = false;
  bool like = false;

  Color white = Colors.white;
  Color black = Colors.black;
  Color grey = Colors.grey[300];
  Color red = Color.fromRGBO(238, 0, 38, 1);

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {

      if(_show){
        if (_scrollController.offset.ceil() < 300) {
          setState(() {
            _show = false;
          });
        }
      } else {
        if (_scrollController.offset.ceil() >= 300) {
          setState(() {
            _show = true;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Scaffold(
          body: CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                backgroundColor: Colors.black54,
                pinned: true,
                automaticallyImplyLeading: true,
                expandedHeight: 300,
                flexibleSpace: NewsPortalTitle(news: _news, index: _index),
                actions: _show == true ? <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 20, top: 10),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.remove_red_eye,
                          size: 30,
                          color: Colors.white
                        ),
                        Text(
                          ' 120000',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 20,),
                  Container(
                    padding: EdgeInsets.only(right: 20, top: 10),
                    child: GestureDetector(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            like == false ? Icons.favorite_border : Icons.favorite,
                            size: 30,
                              color: white
                          ),
                          Text(
                            ' 1120000',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      onTap: (){
                        setState(() {
                          like = !like;
                        });
                      },
                    ),
                  ),
                ] : [],
              ),
              SliverList(
                  delegate: SliverChildListDelegate([
                    Container(
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left: 20, top: 10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.remove_red_eye,
                                  size: 30,
                                  color: _show == false ? grey : white,
                                ),
                                Text(
                                  ' 120000',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: _show == false ? black : white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 20,),
                          Container(
                            padding: EdgeInsets.only(right: 20, top: 10),
                            child: GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    like == false ? Icons.favorite_border : Icons.favorite,
                                    size: 30,
                                    color: _show == false ? (like == false ? grey : red) : white,
                                  ),
                                  Text(
                                    ' 1120000',
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: _show == false ? black : white,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: (){
                                setState(() {
                                  like = !like;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Html(
                      backgroundColor: Colors.white,
                      data: _news.slNewsBody,
                      defaultTextStyle: TextStyle(
                          fontSize: 17
                      ),
                      padding: EdgeInsets.all(8.0),
                      onLinkTap: (url) {
                        print("нажал");
                      },
                    ),
                  ])
              )
            ],
          ),
        )
    );
  }
}
