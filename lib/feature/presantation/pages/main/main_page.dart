//import 'package:flutter/material.dart';
//import 'package:flutter_architecture_project/core/constants/constants.dart';
//import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/birthday_main_page_swipe_widget.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/block_main_page_widget.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/news_main_page_swipe_widget.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/polls_main_page_custom_swipe_widget.dart';
//import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/mainPage/vidoes_main_page_swipe_stack_widget.dart';
//import 'package:flutter_bloc/flutter_bloc.dart';
//
//class MainPage extends StatefulWidget {
//
//  @override
//  State<StatefulWidget> createState() => MainPageState();
//}
//
//const String NEWS_PAGE = 'Новости';
//const String POLLS_PAGE = 'Опросы';
//const String VIDEO_PAGE = 'Видеогалерея';
//const String BIRTHDAY_PAGE = 'Дни рождения';
//const String BOOKING_PAGE = 'Бронирование переговорных';
//
//class MainPageState extends State<MainPage> {
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//  }
//
//  void dispatchGetMainParamsFromJson(){
//    context.bloc<MainBloc>().add(GetParamsFromJsonForMainPageBlocEvent());
//  }
//
//  List _mainParams;
//
//  @override
//  Widget build(BuildContext context) {
//
//    dispatchGetMainParamsFromJson();
//
//    return BlocConsumer<MainBloc, MainState>(
//      listener: (context, state) {},
//      builder: (context, state) {
//        if(state is EmptyMainState){
//          return Center(child: Text('загрузка'),);
//
//        } else if(state is LoadedMainParams){
//          _mainParams = state.model.params;
//          return buildBody();
//        } else {
//          return Container();
//        }
//      },
//    );
//  }
//
//  Widget buildBody() {
//    Color grey = Colors.grey[100];
//    Color white = Colors.white;
//
//    int _news;
//    int _polls;
//    int _videos;
//    int _birthday;
//    int _booking;
//    int _counter = 0;
//
//    for(final param in _mainParams){
//      _counter++;
//
//      switch (param['name']){
//        case NEWS_PAGE: _news = _counter; break;
//        case POLLS_PAGE: _polls = _counter; break;
//        case VIDEO_PAGE: _videos = _counter; break;
//        case BIRTHDAY_PAGE: _birthday = _counter; break;
//        case BOOKING_PAGE: _booking = _counter; break;
//      }
//    }
//
//    final pages = {
//      NEWS_PAGE: BlockMainPageWidget(
//        child: NewsMainPageSwipeWidget(),
//        title: NEWS_PAGE,
//        index: NEWS_PAGE_INDEX_NUMBER,
//        background: _news % 2 == 0 ? white : grey,
//      ),
//      POLLS_PAGE: BlockMainPageWidget(
//        child: PollsMainPageCustomSwipeWidget(),
//        title: POLLS_PAGE,
//        index: NEWS_PAGE_INDEX_NUMBER,
//        background: _polls % 2 == 0 ? white : grey,
//      ),
//      VIDEO_PAGE: BlockMainPageWidget(
//        child: VideosMainPageSwipeStackWidget(),
//        title: VIDEO_PAGE,
//        index: NEWS_PAGE_INDEX_NUMBER,
//        background: _videos % 2 == 0 ? white : grey,
//      ),
//      BIRTHDAY_PAGE: BlockMainPageWidget(
//        child: BirthdayMainPageSwipeWidget(),
//        title: BIRTHDAY_PAGE,
//        index: NEWS_PAGE_INDEX_NUMBER,
//        background: _birthday % 2 == 0 ? white : grey,
//      ),
//      BOOKING_PAGE: BlockMainPageWidget(
//        child: Container(child: Center(child: Text('Для этой страницы ещё нету макета'),),),
//        title: BOOKING_PAGE,
//        index: NEWS_PAGE_INDEX_NUMBER,
//        background: _booking % 2 == 0 ? white : grey,
//      ),
//    };
//
//    List<Widget> list = [];
//
//    for(final param in _mainParams){
//      if(param['status'] == true){
//        list.add(pages[param['name']]);
//      }
//    }
//
//    if(list.length == 0){
//      return Container(
//        child: Center(
//          child: Text('Вы ничего не выбрали'),
//        ),
//      );
//    }
//
//    return SmartRefresherWidget(
//      enableControlRefresh: true,
//      enableControlLoad: false,
//      child: CustomScrollView(
//        slivers: <Widget>[
//          SliverList(
//            delegate: SliverChildListDelegate(list),
//          )
//        ],
//      ),
//    );
//  }
//}
