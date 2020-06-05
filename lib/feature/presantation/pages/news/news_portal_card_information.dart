import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/likeSeen/news_portal_likes_seen_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_main_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:get_it/get_it.dart';
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';

class NewsPortalCardInformationPage extends StatefulWidget{

  final NewsModel news;
  final int index;
  final getIt = GetIt.instance;

  NewsPortalCardInformationPage({
    @required this.news,
    @required this.index,
  });

  @override
  State<StatefulWidget> createState() => NewsPortalCardInformationPageState();
}

class NewsPortalCardInformationPageState extends State<NewsPortalCardInformationPage>{

  ScrollController scrollController;

  @override
  void initState() {
    scrollController = new ScrollController();

    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsPortalCardInformationViewModel>.reactive(
      builder: (context, model, child) => Scrollbar(
          child: Scaffold(
            body: CustomScrollView(
              controller: scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black54,
                  pinned: true,
                  automaticallyImplyLeading: true,
                  expandedHeight: 300,
                  flexibleSpace: NewsPortalMainItem(news: widget.news, index: widget.index, fromCard: true),
                  actions: <Widget>[
                    Container(
                        margin: EdgeInsets.only(right: 20),
                        child: AnimatedOpacity(
                          child: LikesSeenWidget(likeFunc: model.like, news: widget.news, color: Colors.white,),
                          duration: Duration(milliseconds: 200),
                          opacity: model.show ? 1 : 0,
                        )
                    ),
                  ],
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.only(right: 20, top: 10),
                        child: AnimatedOpacity(
                          child: LikesSeenWidget(likeFunc: model.like, news: widget.news, color: Colors.grey,),
                          duration: Duration(milliseconds: 200),
                          opacity: model.show ? 0 : 1,
                        )
                      ),
                      Html(
                        backgroundColor: Colors.white,
                        data: widget.news.body,
                        defaultTextStyle: TextStyle(
                            fontSize: 17
                        ),
                        padding: EdgeInsets.all(8.0),
                        onLinkTap: (url) =>
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WebviewScaffold(
                                    appBar: AppBar(backgroundColor: Colors.black54,),
                                    enableAppScheme: true,
                                    withZoom: true,
                                    withLocalStorage: true,
                                    hidden: true,
                                    withOverviewMode: true,
                                    url: url,
                                  ),
                                )
                            ),
//                        onLinkTap: (url) =>
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (context) => WebviewScaffold(
//                                      appBar: AppBar(backgroundColor: Colors.black54,),
//                                      enableAppScheme: true,
//                                      withZoom: true,
//                                      withLocalStorage: true,
//                                      hidden: true,
//                                      withOverviewMode: true,
//                                      url: url,
//                                    ),
//                                )
//                            ),
                      ),
                    ])
                )
              ],
            ),
          )
      ),
      viewModelBuilder: () => NewsPortalCardInformationViewModel(
          news: widget.news,
          newsBloc: BlocProvider.of<NewsPortalBloc>(context),
          index: widget.index,
        scrollController: scrollController
      ),
    );
  }
}