import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';

class MainPage extends StatelessWidget {
  final Function updateIndex;
  final news;
  final mainParams;

  MainPage({this.updateIndex, this.news, this.mainParams}) {
    assert(updateIndex != null);
  }

  @override
  Widget build(BuildContext context) {
    final pages = {
      'Новости': BlockMainPageWidget(
          child: NewsMainPageSwipeWidget(news),
          title: 'Новости',
          updateIndex: updateIndex,
          index: 1
      ),
      'Опросы': BlockMainPageWidget(
        child: PollsMainPageCustomSwipeWidget(),
        title: 'Опросы',
        background: Colors.grey[100],
        updateIndex: updateIndex,
      ),
      'Видеогалерея': BlockMainPageWidget(
        child: VideosMainPageSwipeStackWidget(),
        title: 'Видео',
      ),
      'Дни рождения': BlockMainPageWidget(
        child: BirthdayMainPageSwipeWidget(),
        title: 'Дни рождения',
        background: Colors.grey[100],
        updateIndex: updateIndex,
      ),
      'Бронирование переговорных': BlockMainPageWidget(
        child: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),),
        title: 'Бронирование',
        background: Colors.grey[100],
        updateIndex: updateIndex,
      ),
    };

    List<Widget> list = [];

    for(final param in mainParams){
      if(param['status'] == true){
        list.add(pages[param['name']]);
      }
    }

    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(list),
          )
        ]
    );
  }
}
