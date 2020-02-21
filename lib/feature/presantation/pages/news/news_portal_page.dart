import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/mixins/flushbar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_cupertino_indicator_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var _news;

int _top = 10;

bool _disableRefreshNews = false;
bool _disableNextNews = false;
bool _cupertinoIndicator = false;

int minutes;

void disableOrEnable(bool trueOrFalse, bool cupertino){
  _disableRefreshNews = trueOrFalse;
  _disableNextNews = trueOrFalse;
  _cupertinoIndicator = cupertino;
}

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
  void dispatchGetNewsDataFromCache(){
    context.bloc<NewsPortalBloc>().add(GetNewsPortalFromCacheBlocEvent(0 ,_top));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsPortalBloc, NewsPortalState>(
      builder: (context, state) {
        if (state is EmptyNewsPortal) {
          dispatchGetNewsDataFromCache();
          return NewsPortalPageShimmer();

        } else if (state is LoadingNewsPortal) {
          return NewsPortalPageShimmer();

        } else if (state is LoadedNewsPortal) {
          disableOrEnable(false, false);
          _news = state.model.news;
          return NewsPortalBody();

        } else if (state is ErrorNewsPortal) {
          dispatchGetNewsDataFromCache();
          return NewsPortalPageShimmer();
        } else {
          return Container();
        }
      },
      listener: (context, state) {
        if(state is ErrorNewsPortal){
          flushbar(context, state.message);
        } else if(state is LoadedNewsPortal){}
      },
    );
  }
}

class NewsPortalBody extends StatefulWidget {

  @override
  NewsPortalBodyState createState() => NewsPortalBodyState();
}

class NewsPortalBodyState extends State<NewsPortalBody> with AutomaticKeepAliveClientMixin{
  ScrollController _scrollController = new ScrollController();
  BouncingScrollPhysics _bouncingScrollPhysics = BouncingScrollPhysics();
  GlobalKey<RefreshIndicatorState> refreshKey;

  @override
  bool get wantKeepAlive => true;

  void dispatchGetNewsDataFromNetwork({indicator = false}){
    disableOrEnable(true, indicator);

    context.bloc<NewsPortalBloc>().add(GetNewsPortalFromNetworkBlocEvent(skip: 0 ,top: _top));
  }

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
          setState(() {
            _top += 10;
            dispatchGetNewsDataFromNetwork(indicator: true);
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: () async {
          if(!_disableRefreshNews){
            dispatchGetNewsDataFromNetwork();
          }
        },
        key: refreshKey,
        child: CustomScrollView(
          controller: _scrollController,
          physics: _bouncingScrollPhysics,
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
                  NewsPortalCupertinoIndicator(cupertinoIndicator: _cupertinoIndicator),
                  SizedBox(height: 50,)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}