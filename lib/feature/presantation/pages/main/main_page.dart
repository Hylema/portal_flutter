import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

const String NEWS_PAGE = 'Новости';
const String POLLS_PAGE = 'Опросы';
const String VIDEO_PAGE = 'Видеогалерея';
const String BIRTHDAY_PAGE = 'Дни рождения';
const String BOOKING_PAGE = 'Бронирование переговорных';

class MainPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<MainBloc, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        if(state is EmptyMainState){
          return Center(child: Text('Ошибка...'),);

        } else if(state is LoadedMainParams){
          if(state.model.params.length == 0){
            return Container(
              child: Center(
                child: Text('Вы ничего не выбрали'),
              ),
            );
          } else {
            return MainPageBody(model: state.model);
          }
        } else {
          return Container();
        }
      },
    );
  }
}

class MainPageBody extends StatelessWidget {

  final MainParamsModel model;
  MainPageBody({@required this.model});

  final Color grey = Colors.grey[100];
  final Color white = Colors.white;

  int _news;
  int _polls;
  int _videos;
  int _birthday;
  int _booking;
  int _counter = 0;
  
  @override
  Widget build(BuildContext context) {

    for(final param in model.params){
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
        title: NEWS_PAGE,
        index: NEWS_PAGE_INDEX_NUMBER,
        background: _news % 2 == 0 ? white : grey,
      ),
      POLLS_PAGE: BlockMainPageWidget(
        child: PollsMainPageCustomSwipeWidget(),
        title: POLLS_PAGE,
        index: NEWS_PAGE_INDEX_NUMBER,
        background: _polls % 2 == 0 ? white : grey,
      ),
      VIDEO_PAGE: BlockMainPageWidget(
        child: VideosMainPageSwipeStackWidget(),
        title: VIDEO_PAGE,
        index: NEWS_PAGE_INDEX_NUMBER,
        background: _videos % 2 == 0 ? white : grey,
      ),
      BIRTHDAY_PAGE: BlockMainPageWidget(
        child: BirthdayMainPageSwipeWidget(),
        title: BIRTHDAY_PAGE,
        index: NEWS_PAGE_INDEX_NUMBER,
        background: _birthday % 2 == 0 ? white : grey,
      ),
      BOOKING_PAGE: BlockMainPageWidget(
        child: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),),
        title: BOOKING_PAGE,
        index: NEWS_PAGE_INDEX_NUMBER,
        background: _booking % 2 == 0 ? white : grey,
      ),
    };

    List<Widget> list = [];

    for(final param in model.listStatusWithTrue){
      list.add(pages[param['name']]);
    }

    return SmartRefresherWidget(
      enableControlRefresh: false,
      enableControlLoad: false,
      hasReachedMax: true,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(list),
          )
        ],
      ),
    );
  }
}
