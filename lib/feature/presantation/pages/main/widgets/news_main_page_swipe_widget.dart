import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/news/news_portal_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
class NewsMainPageSwipeWidget extends StatelessWidget{
  final NewsPortalBloc bloc;
  NewsMainPageSwipeWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPortalBloc, NewsPortalState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is EmptyNewsPortal) {
          return Container();
        } else if (state is LoadingNewsPortal) {
          return Container();
        } else if (state is LoadedNewsPortal) {
          return NewsMainPageSwipeWidgetBody(news: state.listModels, bloc: bloc,);
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
  final NewsPortalBloc bloc;
  NewsMainPageSwipeWidgetBody({this.news, @required this.bloc});

  @override
  Widget build(BuildContext context) {
    return Orientation.portrait == MediaQuery.of(context).orientation ? Container(
        height: 250,
        child: Swiper(
            autoplay: true,
            autoplayDelay: 10000,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: NewsPortalItem(vertical: true, news: news[index], index: index, bloc: bloc),
              );
            },
            itemCount: news.length,
            viewportFraction: 0.8
        )
    ) : Container(
        height: 200,
        child: Swiper(
            autoplay: true,
            autoplayDelay: 10000,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                child: NewsPortalItem(vertical: true, news: news[index], index: index, bloc: bloc),
              );
            },
            itemCount: news.length,
            viewportFraction: 0.5
        )
    );
  }
}
