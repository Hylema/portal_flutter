import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/data/repositories/news/news_portal_repository.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/news/news_portal_repository_interface.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/likeNews/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_card_information_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_likes_seen_widget.dart';
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


class NewsPortalCardInformationPage extends StatelessWidget {

  final NewsModel news;
  final int index;
  final getIt = GetIt.instance;

  NewsPortalCardInformationPage({
    @required this.news,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {

    return ViewModelBuilder<NewsPortalCardInformationViewModel>.reactive(
      builder: (context, model, child) => Scrollbar(
          child: Scaffold(
            body: CustomScrollView(
              controller: model.scrollController,
              slivers: <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.black54,
                  pinned: true,
                  automaticallyImplyLeading: true,
                  expandedHeight: 300,
                  flexibleSpace: NewsPortalMainItem(news: news, index: index, fromCard: true),
                  actions: <Widget>[
                    AnimatedOpacity(
                      alwaysIncludeSemantics: true,
                      duration: Duration(milliseconds: 200),
                      child: Container(
                        padding: EdgeInsets.only(left: 20, top: 10),
                        child: Row(
                          children: <Widget>[
                            Icon(
                                Icons.remove_red_eye,
                                size: 30,
                                color: Colors.white
                            ),
                            Text(
                              ' ${news.viewedCount}',
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                      opacity: model.show ? 1 : 0,
                    ),
                    SizedBox(width: 20,),
                    BlocConsumer<LikeNewsBloc, LikeNewsState>(
                      // ignore: missing_return
                      bloc: LikeNewsBloc(
                          repository: getIt<INewsPortalRepository>()
                      ),
                      builder: (context, state) {
                        int likeCount = news.likesCount;

                        if(state is LoadedLikesState) likeCount = state.likes;

                        return AnimatedOpacity(
                          alwaysIncludeSemantics: true,
                          duration: Duration(milliseconds: 200),
                          child: Container(
                            padding: EdgeInsets.only(right: 20, top: 10),
                            child: GestureDetector(
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                      !news.isLike() ? Icons.favorite_border : Icons.favorite,
                                      size: 30,
                                      color: Colors.white
                                  ),
                                  Text(
                                    ' $likeCount',
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                ],
                              ),
//                              onTap: () => model.like(guid: news.guid, id: news.id),
                            ),
                          ),
                          opacity: model.show ? 1 : 0,
                        );
                      },
                      listener: (context, state) {},
                    ),
                  ],
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
//                      Container(
//                        color: Colors.white,
//                        child: Row(
//                          mainAxisAlignment: MainAxisAlignment.end,
//                          children: <Widget>[
//                            Container(
//                              padding: EdgeInsets.only(left: 20, top: 10),
//                              child: Row(
//                                children: <Widget>[
//                                  Icon(
//                                    Icons.remove_red_eye,
//                                    size: 30,
//                                    color: !model.show ? Colors.grey[300] : Colors.white,
//                                  ),
//                                  Text(
//                                    ' ${news.viewedCount}',
//                                    style: TextStyle(
//                                      fontSize: 15,
//                                      color: !model.show ? Colors.black : Colors.white,
//                                    ),
//                                  ),
//                                ],
//                              ),
//                            ),
//                            SizedBox(width: 20,),
//                            Container(
//                              padding: EdgeInsets.only(right: 20, top: 10),
//                              child: GestureDetector(
//                                child: Row(
//                                  children: <Widget>[
//                                    Icon(
//                                      !news.isLike() ? Icons.favorite_border : Icons.favorite,
//                                      size: 30,
//                                      color: !model.show ? (!news.isLike() ? Colors.grey[300] : Color.fromRGBO(238, 0, 38, 1)) : Colors.white,
//                                    ),
//                                    Text(
//                                      ' ${news.likesCount}',
//                                      style: TextStyle(
//                                        fontSize: 15,
//                                        color: !model.show ? Colors.black : Colors.white,
//                                      ),
//                                    ),
//                                  ],
//                                ),
//                                onTap: () => model.like(guid: news.guid, id: news.id),
//                              ),
//                            )
//                          ],
//                        ),
//                      ),
                    Container(
                      color: Colors.white,
                      margin: EdgeInsets.only(right: 20, top: 10),
                      child: LikesSeenWidget(likeFunc: model.like, news: news, color: Colors.grey,),
                    ),
//                      SelectableText(document.outerHtml, showCursor: true, cursorWidth: 5,),
                      Html(
                        backgroundColor: Colors.white,
                        data: news.body,
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
                      ),
                    ])
                )
              ],
            ),
          )
      ),
      viewModelBuilder: () => NewsPortalCardInformationViewModel(
        news: news,
        likeNewsBloc: BlocProvider.of<LikeNewsBloc>(context),
      ),
    );
  }
}
