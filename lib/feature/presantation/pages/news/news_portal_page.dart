import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_main_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_model_sheet_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/data_from_cache_message.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPortalPage extends StatelessWidget {
  final NewsPortalBloc bloc;
  NewsPortalPage({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsPortalBloc, NewsPortalState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = NewsPortalPageShimmer();

        if (state is LoadingNewsPortal) {
          currentViewOnPage = NewsPortalPageShimmer();

        } else if (state is LoadedNewsPortal) {
          currentViewOnPage = NewsPortalBody(listModels: state.listModels, hasReachedMax: state.hasReachedMax, bloc: bloc);

        } else if (state is NewsFromCacheState){
          currentViewOnPage = NewsPortalBody(listModels: state.listModels, fromCache: true, enableControlLoad: false, bloc: bloc);
        }

        return Scaffold(
          appBar: HeaderAppBar(
            title: 'Новости холдинга',
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: 15.0,
                    top: 7,
                    bottom: 7
                ),
                child: IconButton(
                    onPressed: (){
                      showModalSheet(context);
                    },
                    icon: Image.asset(
                      'assets/icons/change.png',
                    )
                ),
              ),
            ],
          ),
          body: Scrollbar(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: currentViewOnPage,
            ),
          ),
        );
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
  final NewsPortalBloc bloc;

  NewsPortalBody({
    @required this.listModels,
    this.hasReachedMax = false,
    this.fromCache = false,
    this.enableControlLoad = true,
    this.enableControlRefresh = true,
    @required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    print('BUILD!@!!!!!!!!!!!!!!!!!');
    return SmartRefresherWidget(
      enableControlLoad: enableControlLoad,
      enableControlRefresh: enableControlRefresh,
      hasReachedMax: hasReachedMax,
      onRefresh: () => bloc.add(UpdateNewsEvent()),
      onLoading: () => bloc.add(FetchNewsEvent()),
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
              flexibleSpace: NewsPortalMainItem(news: listModels[0], bloc: bloc),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index) =>
                NewsPortalItem(news: listModels[++index], index: index, bloc: bloc),
                childCount: (listModels.length - 1)
            ),
          ),
        ],
      ),
    );
  }
}