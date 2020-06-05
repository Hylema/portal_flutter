import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_main_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPortalPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsPortalBloc, NewsPortalState>(
      // ignore: missing_return
      builder: (context, state) {
        if (state is LoadingNewsPortal) {
          return NewsPortalPageShimmer();

        } else if (state is LoadedNewsPortal) {
          return NewsPortalBody(listModels: state.listModels, hasReachedMax: state.hasReachedMax);

        } else if (state is NewsFromCacheState){
          return NewsPortalBody(listModels: state.listModels, fromCache: true, enableControlLoad: false);

        } else return NewsPortalPageShimmer();
      },
      listener: (context, state) {},
    );
  }
}

class NewsPortalBody extends StatelessWidget{

  final List<NewsModel> listModels;
  final bool hasReachedMax;
  final bool fromCache;
  final bool enableControlLoad;
  final bool enableControlRefresh;

  NewsPortalBody({
    @required this.listModels,
    this.hasReachedMax = false,
    this.fromCache = false,
    this.enableControlLoad = true,
    this.enableControlRefresh = true,
  });

  @override
  Widget build(BuildContext context) {
    print('BUILD!@!!!!!!!!!!!!!!!!!');
    return SmartRefresherWidget(
      enableControlLoad: enableControlLoad,
      enableControlRefresh: enableControlRefresh,
      hasReachedMax: hasReachedMax,
      onRefresh: () => BlocProvider.of<NewsPortalBloc>(context).add(UpdateNewsEvent()),
      onLoading: () => BlocProvider.of<NewsPortalBloc>(context).add(FetchNewsEvent()),
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              DataFromCacheMessageWidget(fromCache: fromCache),
            ]),
          ),
          SliverAppBar(
              backgroundColor: Colors.black26,
              pinned: false,
              automaticallyImplyLeading: false,
              expandedHeight: 245,
              flexibleSpace: NewsPortalMainItem(news: listModels[0])
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) =>
                NewsPortalItem(news: listModels[++index], index: index),
                childCount: (listModels.length - 1)
            ),
          ),
        ],
      ),
    );
  }
}