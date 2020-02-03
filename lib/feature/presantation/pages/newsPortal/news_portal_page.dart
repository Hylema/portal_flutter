import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/newsPortal/news_portal_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_cupertino_indicator_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsPortalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          builder: (context) => sl<NewsPortalBloc>(),
          child: BuildPageNewsPortal()
      ),
    );
  }
}

class BuildPageNewsPortal extends StatefulWidget {

  @override
  BuildPageNewsPortalState createState() => BuildPageNewsPortalState();
}

class BuildPageNewsPortalState extends State<BuildPageNewsPortal>{
  GlobalKey<RefreshIndicatorState> refreshKey;
  int skipNews = 0;
  int top = 5;

  var _news;

  bool _disableRefreshNews = false;
  bool _disableNextNews = false;
  bool _cupertinoIndicator = false;
  ScrollController _scrollController = new ScrollController();

  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {
        if(!_disableNextNews){
          this.top += 5;
          dispatchNextNewsPortal();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: refreshKey,
      onRefresh: () async {
        if(!_disableRefreshNews){
          dispatchRefreshNewsPortal();
        }
      },
      child: Scrollbar(
        child: BlocBuilder<NewsPortalBloc, NewsPortalState>(
          builder: (context, state) {

            print('STATE IS $state');

            if(state is Empty){
              dispatchFirstNewsPortal();
              return ShimmerList();
            } else if(state is Loading) {
            } else if (state is Loaded){
              print('STATE Loaded');
              _news = state.model.news;
              disableOrEnable(false);
            } else if(state is Error){
              return Container(
                child: Center(
                  child: Text(state.message),
                ),
              );
            }

            print('news === $_news');

            return Stack(
              children: <Widget>[
                SafeArea(
                  child: CustomScrollView(
                    controller: _scrollController,
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
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            NewsPortalCupertinoIndicator(cupertinoIndicator: _cupertinoIndicator)
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void disableOrEnable(bool trueOrFalse){
    _disableRefreshNews = trueOrFalse;
    _disableNextNews = trueOrFalse;
    _cupertinoIndicator = trueOrFalse;
  }

  void dispatchNextNewsPortal() {
    disableOrEnable(true);
    BlocProvider.of<NewsPortalBloc>(context)
        .dispatch(GetNextNewsPortalBloc(0, this.top));
  }

  void dispatchRefreshNewsPortal() {
    disableOrEnable(true);
    BlocProvider.of<NewsPortalBloc>(context)
        .dispatch(RefreshNewsPortalBloc(0, this.top));
  }

  void dispatchFirstNewsPortal() {
    BlocProvider.of<NewsPortalBloc>(context)
        .dispatch(GetFirstNewsPortalBloc(0, 5));
  }
}