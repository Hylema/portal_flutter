import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/carousels/custom_carousel_slide_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/carousels/custom_carousel_swap_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_carousel_widget.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlockMainPageWidget(
                  child: NewsMainPageCarouselWidget(),
                  title: 'Новости',
                ),
                BlockMainPageWidget(
                  child: CustomCarouselSlideWidget(),
                  title: 'Опросы',
                  background: Colors.grey[100],
                ),
                BlockMainPageWidget(
                  child: NewsMainPageCarouselWidget(),
                  title: 'Видео',
                ),
                BlockMainPageWidget(
                  child: CustomCarouselSwapWidget(),
                  title: 'Дни рождения',
                  background: Colors.grey[100],
                ),
              ],
            ),
          )
        ]
    );
  }
}
