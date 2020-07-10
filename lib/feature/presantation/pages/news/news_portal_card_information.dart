import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/likeSeen/news_portal_like_seen_widger_viewmodel.dart';
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

class NewsPortalCardInformationPage extends StatelessWidget{
  final NewsModel news;
  final int index;
  final NewsPortalBloc bloc;
  final getIt = GetIt.instance;

  NewsPortalCardInformationPage({
    @required this.news,
    @required this.index,
    @required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewsPortalCardInformationViewModel>.reactive(
      builder: (context, model, child) {
        final NewsPortalLikeSeenWidgetViewModel _newsPortalLikeSeenWidgetViewModel = new NewsPortalLikeSeenWidgetViewModel(
          index: index,
          newsBloc: bloc,
          news: news
        );
        return Scrollbar(
            child: Scaffold(
              body: CustomScrollView(
                controller: model.scrollController,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: Colors.black54,
                    pinned: true,
                    automaticallyImplyLeading: true,
                    expandedHeight: 300,
                    flexibleSpace: NewsPortalMainItem(news: news, index: index, fromCard: true, bloc: bloc,),
                    actions: <Widget>[
                      Container(
                          margin: EdgeInsets.only(right: 20),
                          child: AnimatedOpacity(
                            child: LikesSeenWidget(news: news, color: Colors.white, viewModel: _newsPortalLikeSeenWidgetViewModel),
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
                              child: LikesSeenWidget(news: news, color: Colors.grey, viewModel: _newsPortalLikeSeenWidgetViewModel),
                              duration: Duration(milliseconds: 200),
                              opacity: model.show ? 0 : 1,
                            )
                        ),
                        Html(
                          backgroundColor: Colors.white,
                          data: news.body,
                          defaultTextStyle: TextStyle(
                              fontSize: 17
                          ),
                          padding: EdgeInsets.all(8.0),
//                        customRender: (dom.Node node, List<Widget> children) {
//                          List<TextSpan> list = [];
//                          String text = node.text;
//                          print('node =========== ${node.text}');
//                          print('children =========== ${children}');
//                          return SelectableText(node.text);
//                        },
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
                        ),
                      ])
                  )
                ],
              ),
            )
        );
      },
      viewModelBuilder: () => NewsPortalCardInformationViewModel(
          news: news,
          newsBloc: bloc,
      ),
    );
  }
}