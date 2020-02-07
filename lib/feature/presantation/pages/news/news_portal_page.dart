import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_cupertino_indicator_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_title_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

int skipNews = 0;
int top = 5;

bool _disableRefreshNews = false;
bool _disableNextNews = false;
bool _cupertinoIndicator = false;

void disableOrEnable(bool trueOrFalse){
  _disableRefreshNews = trueOrFalse;
  _disableNextNews = trueOrFalse;
  _cupertinoIndicator = trueOrFalse;
}




class NewsPortalPage extends StatelessWidget {
  var news;
  NewsPortalPage({this.news});


  @override
  Widget build(BuildContext context) {
    print('news ==================================== $news');
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<NewsPortalBloc>(),
          child: BuildPageNewsPortal()
      ),
    );
  }
}
class BuildPageNewsPortal extends StatelessWidget{
  var news;
  BuildPageNewsPortal({this.news});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPortalBloc, NewsPortalState>(
      builder: (context, state) {
        if (state is EmptyNewsPortal) {
          if(news == null){
            return NewsPortalShimmer();
          } else {
            return NewsPortalBody(news: news,);
          }
        } else if (state is LoadingNewsPortal) {
          return NewsPortalShimmer();
        } else if (state is LoadedNewsPortal) {
          news = state.model.news;
          return NewsPortalBody(news: news,);
        } else if (state is ErrorNewsPortal) {
          return Container(
            child: Center(
              child: Text(state.message),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}


class NewsPortalBody extends StatefulWidget {
  final news;
  NewsPortalBody({this.news});

  @override
  NewsPortalBodyState createState() => NewsPortalBodyState();
}
class NewsPortalBodyState extends State<NewsPortalBody> {
  ScrollController _scrollController = new ScrollController();
  GlobalKey<RefreshIndicatorState> refreshKey;
  var news;
  @override
  void dispose(){
    _scrollController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    news = widget.news;
    print('RENDER NEWS PORTAL');

    _scrollController.addListener(() {
      if (_scrollController.offset ==
          _scrollController.position.maxScrollExtent) {

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: RefreshIndicator(
        onRefresh: () async {},
        key: refreshKey,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: <Widget>[
            SliverAppBar(
                backgroundColor: Colors.black26,
                pinned: false,
                automaticallyImplyLeading: false,
                expandedHeight: 245,
                flexibleSpace: NewsPortalTitle(news: news[0])
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                index++;
                final newss = news[index];

                return NewsPortalItems(news: newss, index: index);
              },
                  childCount: (news.length - 1)
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
    );
  }
}