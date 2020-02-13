import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

var _news;
var _updateIndex;
var _mainParams;

class MainPage extends StatelessWidget {

  MainPage({updateIndex, news, mainParams}) {
    assert(updateIndex != null);
    _news = news;
    _updateIndex = updateIndex;
    _mainParams = mainParams;
  }

  @override
  Widget build(BuildContext context) {
    return MainPageBuild();
  }
}

class MainPageBuild extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
//      listenWhen: (previous, current) {
//
//      },
      listener: (context, state) {

      },
      buildWhen: (previous, current) {
        print('previous =========================== $previous');
        print('current =========================== $current');
        return true;
      },
      builder: (context, state) {
        if(state is EmptyMainState){
          if(_mainParams == null){
            return Center(child: Text('загрузка'),);
          }
          else return buildBody();
        } else if(state is LoadedMainState){
          _mainParams = GlobalData.mainParams;
          return buildBody();
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildBody() {
    final pages = {
      'Новости': BlockMainPageWidget(
          child: NewsMainPageSwipeWidget(_news),
          title: 'Новости',
          updateIndex: _updateIndex,
          index: 1
      ),
      'Опросы': BlockMainPageWidget(
        child: PollsMainPageCustomSwipeWidget(),
        title: 'Опросы',
        background: Colors.grey[100],
        updateIndex: _updateIndex,
      ),
      'Видеогалерея': BlockMainPageWidget(
        child: VideosMainPageSwipeStackWidget(),
        title: 'Видео',
      ),
      'Дни рождения': BlockMainPageWidget(
        child: BirthdayMainPageSwipeWidget(),
        title: 'Дни рождения',
        background: Colors.grey[100],
        updateIndex: _updateIndex,
      ),
      'Бронирование переговорных': BlockMainPageWidget(
        child: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),),
        title: 'Бронирование',
        background: Colors.grey[100],
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
