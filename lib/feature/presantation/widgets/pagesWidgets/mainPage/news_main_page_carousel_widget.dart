import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_items_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/injection_container.dart';

class NewsMainPageCarouselWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (context) => sl<NewsPortalBloc>(),
        child: NewsMainPageCarousel()
    );
  }
}

class NewsMainPageCarousel extends StatefulWidget {

  @override
  NewsMainPageCarouselState createState() => NewsMainPageCarouselState();
}

class NewsMainPageCarouselState extends State<NewsMainPageCarousel>{
  var _news;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NewsPortalBloc, NewsPortalState>(
      builder: (context, state) {

        print('STATE IS $state');

        if(state is Empty){

        } else if(state is Loading) {
        } else if (state is Loaded){
          _news = state.model.news;

          print('news === $_news');
          print('news ==== $_news');
          print('news ===== $_news');

          return CarouselSlider.builder(
            itemCount: _news.length,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 5),
            autoPlayAnimationDuration: Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            pauseAutoPlayOnTouch: Duration(seconds: 10),
            enlargeCenterPage: true,
            height: 300.0,
            itemBuilder: (BuildContext context, int index) =>
                Container(
                  child: NewsPortalItems(vertical: true, news: _news[index]),
                ),
          );
        } else if(state is Error){
          return Container(
            child: Center(
              child: Text(state.message),
            ),
          );
        }

        return Container();


      },
    );
  }
}