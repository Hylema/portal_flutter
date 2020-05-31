import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/vidoes_main_page_swipe_stack_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

  @override
  Widget build(BuildContext context) {
    final pages = {
      NEWS_PAGE: NewsMainPageSwipeWidget(),
      POLLS_PAGE: PollsMainPageCustomSwipeWidget(),
      VIDEO_PAGE: VideosMainPageSwipeStackWidget(),
      BIRTHDAY_PAGE: BirthdayMainPageSwipeWidget(),
      BOOKING_PAGE: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),)
    };

    List<Widget> list = [];

    for(int i = 0; i < model.params.length; i++){
      if(model.params[i]['visible']){
        list.add(BlockMainPageWidget(
          index: NEWS_PAGE_INDEX_NUMBER,
          title: model.params[i]['title'],
          background: i % 2 == 0 ? white : grey,
          child: pages[model.params[i]['title']],
        ));
      }
    }

    return SmartRefresherWidget(
      enableControlRefresh: false,
      enableControlLoad: false,
      hasReachedMax: true,
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(list),
          )
        ],
      ),
    );
  }
}