import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Function _updateIndex;

class MainPage extends StatelessWidget {

  MainPage({updateIndex, news, mainParams}) {
    assert(updateIndex != null);
    _updateIndex = updateIndex;
  }

  @override
  Widget build(BuildContext context) {
    return MainPageBuild();
  }
}

const String NEWS_PAGE = 'Новости';
const String POLLS_PAGE = 'Опросы';
const String VIDEO_PAGE = 'Видеогалерея';
const String BIRTHDAY_PAGE = 'Дни рождения';
const String BOOKING_PAGE = 'Бронирование переговорных';

class MainPageBuild extends StatelessWidget {

  List _mainParams;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is EmptyMainState){
          return Center(child: Text('загрузка'),);

        } else if(state is LoadedMainState){
          _mainParams = state.model.params;

          return buildBody();
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildBody() {
    Color grey = Colors.grey[100];
    Color white = Colors.white;

    int _news;
    int _polls;
    int _videos;
    int _birthday;
    int _booking;
    int _counter = 0;
    for(final param in _mainParams){
      _counter++;

      switch (param['name']){
        case NEWS_PAGE: _news = _counter; break;
        case POLLS_PAGE: _polls = _counter; break;
        case VIDEO_PAGE: _videos = _counter; break;
        case BIRTHDAY_PAGE: _birthday = _counter; break;
        case BOOKING_PAGE: _booking = _counter; break;
      }
    }

    final pages = {
      NEWS_PAGE: BlockMainPageWidget(
        child: NewsMainPageSwipeWidget(),
        title: 'Новости',
        updateIndex: _updateIndex,
        index: 1,
        background: _news % 2 == 0 ? white : grey,
      ),
      POLLS_PAGE: BlockMainPageWidget(
        child: PollsMainPageCustomSwipeWidget(),
        title: 'Опросы',
        background: _polls % 2 == 0 ? white : grey,
        updateIndex: _updateIndex,
      ),
      VIDEO_PAGE: BlockMainPageWidget(
        child: VideosMainPageSwipeStackWidget(),
        title: 'Видео',
        background: _videos % 2 == 0 ? white : grey,
      ),
      BIRTHDAY_PAGE: BlockMainPageWidget(
        child: BirthdayMainPageSwipeWidget(),
        title: 'Дни рождения',
        background: _birthday % 2 == 0 ? white : grey,
        updateIndex: _updateIndex,
      ),
      BOOKING_PAGE: BlockMainPageWidget(
        child: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),),
        title: 'Бронирование',
        background: _booking % 2 == 0 ? white : grey,
        updateIndex: _updateIndex,
      ),
    };

    List<Widget> list = [];

    for(final param in _mainParams){
      if(param['status'] == true){
        list.add(pages[param['name']]);
      }
    }

    if(list.length == 0){
      return Container(
        child: Center(
          child: Text('Вы ничего не выбрали'),
        ),
      );
    }

    return CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(list..add(SizedBox(height: 80,))),
          )
        ]
    );
  }
}
