import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_cupertino_indicator_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var _news;

class NewsPortalPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BuildPageNewsPortal()
    );
  }
}


class BuildPageNewsPortal extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => BuildPageNewsPortalState();
}
class BuildPageNewsPortalState extends State<BuildPageNewsPortal> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsPortalBloc, NewsPortalState>(
      builder: (context, state) {
        if (state is EmptyNewsPortal) {
          return NewsPortalPageShimmer();

        } else if (state is LoadingNewsPortal) {
          return NewsPortalPageShimmer();

        } else if (state is LoadedNewsPortal) {
          _news = state.listModels;
          return NewsPortalBody();

        } else if (state is ErrorNewsPortal) {
          return NewsPortalPageShimmer();
        } else {
          return Container();
        }
      },
      listener: (context, state) {},
    );
  }
}

class NewsPortalBody extends StatefulWidget {

  @override
  NewsPortalBodyState createState() => NewsPortalBodyState();
}

class NewsPortalBodyState extends State<NewsPortalBody> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;


  @override
  void dispose(){
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      hasReachedMax: false,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
              backgroundColor: Colors.black26,
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 245,
              flexibleSpace: NewsPortalTitle(news: _news[0])
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              index++;
              final news = _news[index];

              return NewsPortalItems(news: news, index: index);
            },
                childCount: (_news.length - 1)
            ),
          ),
        ],
      ),
    );
  }
}