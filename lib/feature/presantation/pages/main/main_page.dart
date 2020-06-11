import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/core/singleton_blocs.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/filter/main_page_filter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/birthday_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/block_main_page_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/news_main_page_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/polls_main_page_custom_swipe_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/widgets/vidoes_main_page_swipe_stack_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class MainPage extends StatelessWidget {
  final MainBloc bloc;
  MainPage({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      bloc: bloc,
      listener: (context, state) {},
      builder: (context, state) {
        Widget currentViewOnPage = Container();

        if(state is EmptyMainState){
          currentViewOnPage = Center(child: Text('Ошибка...'),);

        } else if(state is LoadedMainParams){
          if(state.model.params.length == 0){
            currentViewOnPage = Container(
              child: Center(
                child: Text('Вы ничего не выбрали'),
              ),
            );
          } else {
            currentViewOnPage = MainPageBody(model: state.model);
          }
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 200),
          child: currentViewOnPage,
        );
      },
    );
  }
}

class MainPageBody extends StatelessWidget {
  final getIt = GetIt.instance;
  final MainParamsModel model;
  MainPageBody({@required this.model});

  final Color grey = Colors.grey[100];
  final Color white = Colors.white;

  int _getId(String title){
    if(title == NEWS_PAGE) return NEWS_PAGE_INDEX_NUMBER;
    else if(title == POLLS_PAGE) return POLLS_PAGE_INDEX_NUMBER;
    else if(title == VIDEO_PAGE) return VIDEO_PAGE_INDEX_NUMBER;
    else if(title == BIRTHDAY_PAGE) return BIRTHDAY_PAGE_INDEX_NUMBER;
    else if(title == BOOKING_PAGE) return BOOKING_PAGE_INDEX_NUMBER;
  }

  @override
  Widget build(BuildContext context) {
    final SingletonBlocs singletonBlocs = getIt<SingletonBlocs>();

    final pages = {
      NEWS_PAGE: NewsMainPageSwipeWidget(bloc: singletonBlocs.newsPortalBloc),
      POLLS_PAGE: PollsMainPageCustomSwipeWidget(bloc: singletonBlocs.pollsBloc),
      VIDEO_PAGE: VideosMainPageSwipeStackWidget(bloc: singletonBlocs.videoGalleryBloc),
      BIRTHDAY_PAGE: BirthdayMainPageSwipeWidget(bloc: singletonBlocs.birthdayBloc),
      BOOKING_PAGE: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),)
    };

    List<Widget> list = [];

    for(int i = 0; i < model.params.length; i++){
      if(model.params[i]['visible']){
        list.add(BlockMainPageWidget(
          index: _getId(model.params[i]['title']),
          title: model.params[i]['title'],
          background: i % 2 == 0 ? white : grey,
          child: pages[model.params[i]['title']],
        ));
      }
    }

    return Scaffold(
      backgroundColor: Colors.white.withOpacity(0),
      appBar: HeaderAppBar(
        title: 'Главная',
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPageFilter()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      body: SmartRefresherWidget(
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
      ),
    );
  }
}