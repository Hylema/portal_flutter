import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';

class MainPage extends StatelessWidget {
  final Function updateIndex;
  MainPage({this.updateIndex}) {
    assert(updateIndex != null);
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BlockMainPageWidget(
                  child: NewsMainPageSwipeWidget(),
                  title: 'Новости',
                  updateIndex: updateIndex,
                  index: 1
                ),
                BlockMainPageWidget(
                  child: PollsMainPageCustomSwipeWidget(),
                  title: 'Опросы',
                  background: Colors.grey[100],
                  updateIndex: updateIndex,
                ),
                BlockMainPageWidget(
                  child: VideosMainPageSwipeStackWidget(),
                  title: 'Видео',
                ),
                BlockMainPageWidget(
                  child: BirthdayMainPageSwipeWidget(),
                  title: 'Дни рождения',
                  background: Colors.grey[100],
                  updateIndex: updateIndex,
                ),
              ],
            ),
          )
        ]
    );
  }
}
