import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/wave_animation.dart';
import 'package:flutter_architecture_project/core/mixins/flushbar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/roundedLoadingButton/custom_rounded_loading_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child:  Image.asset(
          "assets/images/metInvestBackground.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(child: BuildBody()),
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}

const String PROFILE_PAGE = 'profile';
const String NEWS_PAGE = 'news';
const String VIDEO_GALLERY_PAGE = 'video';
const String BIRTHDAY_PAGE = 'birthday';

class BuildBody extends StatefulWidget {
  const BuildBody({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BuildBodyState();
}

class BuildBodyState extends State with TickerProviderStateMixin{

  AnimationController scaleController;
  Animation<double> scaleAnimation;
  CustomRoundedLoadingButtonController _btnController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AppPage()));
      }
    });

    _btnController = new CustomRoundedLoadingButtonController();

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(scaleController);
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

  void dispatchLoadingPopularity(){
    context.bloc<NewsPopularityBloc>().add(LoadingPopularityEvent());
  }

  void dispatchGetVideosFromNetwork(){
    context.bloc<VideoGalleryBloc>().add(GetVideos(pageSize: 15, pageIndex: 1));
  }

  void dispatchGetBirthdayFromNetwork(){
    context.bloc<BirthdayBloc>()
        .add(GetBirthdayEvent(
        monthNumber: DateTime.now().month,
        dayNumber: DateTime.now().day,
        pageIndex: 1,
        pageSize: 15
    ));
  }

  var _pages = {
    PROFILE_PAGE: false,
    NEWS_PAGE: false,
    VIDEO_GALLERY_PAGE: false,
    BIRTHDAY_PAGE: false,
  };
  void _dataForPageLoaded(String page){
    _pages[page] = true;

    //print('PAGES =================== $_pages');

    if(
    _pages[PROFILE_PAGE] == true &&
        _pages[NEWS_PAGE] == true &&
        _pages[VIDEO_GALLERY_PAGE] == true &&
        _pages[BIRTHDAY_PAGE] == true
    ){
      dispatchAllPageLoaded();
    }
  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    if(check) scaleController.forward();

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
        BlocListener<NewsPopularityBloc, NewsPopularityState>(
          listener: (context, state) {
            print('NewsPopularityBloc state is $state');
            if(state is ErrorNewsPopularity){
              flushbar(context, state.message);
            }
          },
        ),
        BlocListener<VideoGalleryBloc, VideoGalleryState>(
          listener: (context, state) {
            print('VideoGalleryBloc state is $state');
            if(state is ErrorVideoGalleryState){
              _dataForPageLoaded(VIDEO_GALLERY_PAGE);
              flushbar(context, state.message);
            } else if(state is LoadedVideoGalleryState){
              _dataForPageLoaded(VIDEO_GALLERY_PAGE);
            }
          },
        ),
        BlocListener<BirthdayBloc, BirthdayState>(
          listener: (context, state) {
            print('BirthdayBloc state is $state');
            if(state is ErrorBirthdayState){
              _dataForPageLoaded(BIRTHDAY_PAGE);
              flushbar(context, state.message);
            } else if(state is LoadedBirthdayState){
              _dataForPageLoaded(BIRTHDAY_PAGE);
            }
          },
        ),
        BlocListener<AppBloc, AppState>(
          listener: (context, state) async {
            print('AppBloc state is $state');
            if (state is Start){}
            else if(state is NeedAuth){
              _btnController.needAuth();
              await Future.delayed(Duration(milliseconds: 1000), () {});
              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AuthPage()));
            }
            else if(state is Finish){
              _btnController.success();

              await Future.delayed(Duration(milliseconds: 1000), () {});

              setState(() {
                check = true;
              });
            }
          },
        ),
      ],
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment(0, 0),
                child: Image.asset(
                  'assets/images/metInvestIcon.png',
                  width: 220,
                ),
              ),
              Align(
                  alignment: Alignment(0, 0.8),
                  child: AnimatedBuilder(
                    animation: scaleAnimation,
                    builder: (context, child) => Transform.scale(
                      scale: scaleAnimation.value,
                      child: check == false ? CustomRoundedLoadingButton(
                        child: Text('Начать', style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () {
                          dispatchGetProfileDataFromNetwork();
                          dispatchGetNewsDataFromNetwork();
                          dispatchGetMainParamsFromJson();
                          dispatchLoadingPopularity();
                          dispatchGetVideosFromNetwork();
                          dispatchGetBirthdayFromNetwork();
                        },
                        color: Color.fromRGBO(238, 0, 38, 1),
                      ) : Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(238, 0, 38, 1),
                        ),
                      ),
                    ),
                  )
              ),
            ],
          )
      )
    );
  }
}
