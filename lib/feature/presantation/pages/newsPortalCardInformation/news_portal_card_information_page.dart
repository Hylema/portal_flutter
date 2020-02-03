import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;


class NewsPortalCardInformationPage extends StatelessWidget {
  NewsPortalCardInformationPage({
    this.news,
    this.index,
  }){
    assert(news != null);
    assert(index != null);
  }

  final news;
  final int index;

  @override
  Widget build(BuildContext context) {

    return Scrollbar(
      child: Scaffold(
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxScrolled) => [
            SliverAppBar(
                backgroundColor: Colors.black26,
                pinned: true,
                automaticallyImplyLeading: true,
                expandedHeight: 245,
                flexibleSpace: NewsPortalTitle(news: news, index: index,)
            ),
          ],
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.remove_red_eye,
                              size: 24,
                              color: Colors.grey,
                            ),
                            Text(
                              ' 12',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(right: 20),
                      ),
                      Container(
                        child: GestureDetector(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.favorite_border,
                                size: 24,
                                color: Colors.grey,
                              ),
                              Text(
                                ' 1',
                                style: TextStyle(
                                  fontSize: 15,
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
//                Html(
//                  data: subText,
//                  padding: EdgeInsets.all(8.0),
//                  onLinkTap: (url) {
//                    print("нажал");
//                  },
//                ),
                Html(
                  data: news['slNewsBody'],
                  defaultTextStyle: TextStyle(
                      fontSize: 17
                  ),
                  padding: EdgeInsets.all(8.0),
                  onLinkTap: (url) {
                    print("нажал");
                  },
//            customRender: (node, children) {
//              if (node is dom.Element) {
//                switch (node.localName) {
//                  case "custom_tag":
//                    return Column(children: children);
//                }
//              }
//            },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}