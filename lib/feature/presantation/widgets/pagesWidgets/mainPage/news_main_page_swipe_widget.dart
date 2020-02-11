import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

var _news;

class NewsMainPageSwipeWidget extends StatelessWidget {

  NewsMainPageSwipeWidget(news){
    _news = news;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => sl<NewsPortalBloc>(),
        child: NewsMainPageCarousel()
    );
  }
}

class NewsMainPageCarousel extends StatefulWidget {

  @override
  NewsMainPageCarouselState createState() => NewsMainPageCarouselState();
}

class NewsMainPageCarouselState extends State<NewsMainPageCarousel> with AutomaticKeepAliveClientMixin<NewsMainPageCarousel>{
  bool noData = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPortalBloc, NewsPortalState>(
      builder: (context, state) {
        if (state is EmptyNewsPortal) {
          _news = GlobalData.news;
          if(_news == null){
            return Container();
          } else {
            return NewsMainPageSwipeWidgetBody(news: _news,);
          }
        } else if (state is LoadingNewsPortal) {
          return Container();
        } else if (state is LoadedNewsPortal) {
          _news = state.model.news;
          return NewsMainPageSwipeWidgetBody(news: _news,);
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

class NewsMainPageSwipeWidgetBody extends StatelessWidget {
  final news;
  NewsMainPageSwipeWidgetBody({this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: EdgeInsets.only(bottom: 20),
      child: Swiper(
          autoplay: true,
          autoplayDelay: 5000,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: NewsPortalItems(vertical: true, news: news[index], index: index,),
            );
          },
          itemCount: news.length,
          viewportFraction: 0.8
      )
    );
  }
}
