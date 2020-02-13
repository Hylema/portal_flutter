import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/mixins/flushbar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/progress_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/action_button_navigation_bar_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/main_floating_action_button_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_model_sheet_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultBottomBarController(
      dragLength: 500,
      snap: true,
      child: Page()
    );
  }
}

class Page extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PageState();
}

const String PROFILE_PAGE = 'profile';
const String NEWS_PAGE = 'news';

class PageState extends State<Page> {
  int _selectedTab = 0;

  @override
  void initState(){
    super.initState();

    dispatchGetProfileDataFromNetwork();
    dispatchGetNewsDataFromNetwork();
    dispatchGetMainParamsFromJson();
  }

  var _pages = {
    PROFILE_PAGE: false,
    NEWS_PAGE: false,
  };
  void _dataForPageLoaded(String page){
    _pages[page] = true;

    if(
    _pages[PROFILE_PAGE] == true &&
        _pages[NEWS_PAGE] == true
    ){
      dispatchAllPageLoaded();
    }
  }

  void _updateIndex(int index){
    setState(() {
      _selectedTab = index;
    });
  }


  void dispatchGetNewsDataFromNetwork(){
    context.bloc<NewsPortalBloc>().add(GetNewsPortalFromNetworkBlocEvent(skip: 0 , top: 10));
  }
  void dispatchGetNewsDataFromCache(){
    context.bloc<NewsPortalBloc>().add(GetNewsPortalFromCacheBlocEvent(0 ,10));
  }


  void dispatchGetProfileDataFromNetwork(){
    context.bloc<ProfileBloc>().add(GetProfileFromNetworkBlocEvent());
  }
  void dispatchGetProfileDataFromCache(){
    context.bloc<ProfileBloc>().add(GetProfileFromCacheBlocEvent());
  }


  void dispatchNeedAuth(){
    context.bloc<AppBloc>().add(NeedAuthEvent());
  }
  void dispatchAllPageLoaded(){
    context.bloc<AppBloc>().add(LoadedEvent());
  }


  void dispatchGetMainParamsFromJson(){
    context.bloc<MainBloc>().add(GetParamsFromJsonForMainPageBlocEvent());
  }


  @override
  Widget build(BuildContext context) {
    List<Widget> _headerOptions = [
      HeaderAppMainBar(
        titleText: 'Главная',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, SlideRightRoute(page: MainPageParameters()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'Новости холдинга',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  showModalSheet(context);
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'Профиль',
      ),
      HeaderAppMainBar(
        titleText: 'test',
      ),
      HeaderAppMainBar(
        titleText: 'Дни рождения',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, SlideRightRoute(page: BirthdayPageParameters()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
    ];

    List<Widget> _pageOptions = [
      MainPage(
        updateIndex: _updateIndex,
      ),
      NewsPortalPage(),
      ProfilePage(),
      ProfilePage(),
      BirthdayPage()
    ];

    return MultiBlocListener(
      listeners: [
        BlocListener<ProfileBloc, ProfileState>(
          listener: (context, state) {
            print('ProfileBloc state is $state');
            if(state is NeedAuthProfile){
              dispatchNeedAuth();
            } else if(state is LoadedProfile) {
              _dataForPageLoaded(PROFILE_PAGE);
            } else if(state is ErrorProfile) {
              flushbar(context, state.message);
              _dataForPageLoaded(PROFILE_PAGE);
            }
          },
        ),
        BlocListener<NewsPortalBloc, NewsPortalState>(
          listener: (context, state) {
            print('NewsPortalBloc state is $state');
            if(state is NeedAuthNews){
              dispatchNeedAuth();
            } else if(state is LoadedNewsPortal){
              _dataForPageLoaded(NEWS_PAGE);
            } else if(state is ErrorNewsPortal) {
              flushbar(context, state.message);
              _dataForPageLoaded(NEWS_PAGE);
            }
          },
        ),
        BlocListener<MainBloc, MainState>(
          listener: (context, state) {
            print('MainBloc state is $state');
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) {
            print('AppBloc state is $state');
            if (state is Start){}
            else if(state is NeedAuth){}
            else if(state is LoadedNewsPortal){}
          },
        ),
      ],
      child: BlocBuilder<AppBloc, AppState>(

        builder: (context, state) {
          if (state is Start){
            return ProgressBar();
          } else if(state is Waiting) {
            return ProgressBar();
          } else if(state is NeedAuth){
            return AuthPage();
          } else if(state is Finish) {

            return SafeArea(
                child: Container(
                  constraints: BoxConstraints(maxWidth: 100),
                  color: Colors.green,
                  child: Scaffold(
                    extendBody: true,
                    appBar: _headerOptions[_selectedTab],
                    body: _pageOptions[_selectedTab],
                    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    floatingActionButton: MainFloatingActionButtonWidget(),
                    bottomNavigationBar: ActionButtonNavigationBarWidget(
                      selectedIndex: _selectedTab,
                      updateIndex: _updateIndex,
                    ),
                  ),
                )
            );
          }
          return Container(child: Center(child: Text('Что-то пошло не так'),),);
        },
      ),
    );
  }
}