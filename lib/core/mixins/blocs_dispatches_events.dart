import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/mixins/blocs.dart';
import 'package:flutter_architecture_project/core/mixins/singleton.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/blocsResponses/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';

///State новостей
int _downloadNews = 15;
int _moreCountDownloadNews = 10;

///State видео
int _downloadVideo = 15;
int _moreCountDownloadVideo = 10;

class Dispatch {

  ///State дней рождения
  static int _pageSize = 45;

  Blocs blocs = Singleton.blocsClass;

  ///Новости
  void dispatchGetNewsDataFromNetwork(){
    blocs.newsBloc.add(GetNewsPortalFromNetworkBlocEvent(skip: 0 , top: _downloadNews));
  }
  void dispatchLoadMoreNewsDataFromNetwork(){
    _downloadNews += _moreCountDownloadNews;

    blocs.newsBloc.add(GetNewsPortalFromNetworkBlocEvent(skip: 0 , top: _downloadNews));
  }
  void dispatchGetNewsDataFromCache(){
    blocs.newsBloc.add(GetNewsPortalFromCacheBlocEvent());
  }

  ///Профиль
  void dispatchGetProfileDataFromNetwork(){
    blocs.profileBloc.add(GetProfileFromNetworkBlocEvent());
  }
  void dispatchGetProfileDataFromCache(){
    blocs.profileBloc.add(GetProfileFromCacheBlocEvent());
  }

  ///App
  void dispatchNeedAuth(){
    blocs.appBloc.add(NeedAuthEvent());
  }
  void dispatchAllPageLoaded(){
    blocs.appBloc.add(LoadedEvent());
  }

  ///Главная
  void dispatchGetMainParamsFromJson(){
    blocs.mainBloc.add(GetParamsFromJsonForMainPageBlocEvent());
  }

  ///Лайки, просмотры
//  void dispatchLoadingPopularity(context){
//    context.bloc<NewsPopularityBloc>().add(LoadingPopularityEvent());
//  }

  ///Видео галерея
  void dispatchGetVideosFromNetwork(){
    blocs.videoGalleryBloc.add(GetVideos(
        pageSize: _downloadVideo,
        pageIndex: 1
    ));
  }
  void dispatchLoadMoreVideosFromNetwork(){
    _downloadVideo += _moreCountDownloadVideo;

    blocs.videoGalleryBloc.add(GetVideos(
        pageSize: _downloadVideo,
        pageIndex: 1
    ));
  }

  ///Дни рождения
  void dispatchLoadMoreBirthdayWithFilter({
    @required int pageIndex,
    @required bool update,
    String fio,
    int startDayNumber,
    int endDayNumber,
    int startMonthNumber,
    int endMonthNumber,
  }){
    blocs.birthdayBloc.add(LoadMoreBirthdayWithFilterEvent(
        fio: fio,
        startDayNumber: startDayNumber,
        endDayNumber: endDayNumber,
        startMonthNumber: startMonthNumber,
        endMonthNumber: endMonthNumber,
        pageSize: BIRTHDAY_PAGE_SIZE,
        pageIndex: pageIndex,
        update: update
    ));
  }
  void dispatchLoadMoreBirthdayWithConcreteDay({
    @required int monthNumber,
    @required int dayNumber,
    @required int pageIndex,
    @required bool update,
  }){
    blocs.birthdayBloc.add(LoadMoreBirthdayWithConcreteDayEvent(
      monthNumber: monthNumber,
      dayNumber: dayNumber,
      pageSize: BIRTHDAY_PAGE_SIZE,
      pageIndex: pageIndex,
      update: update
    ));
  }

  ///Responses
  void dispatchResponseSuccessBloc({@required state}){
    blocs.responsesBloc.add(ResponseSuccessEvent(state: state));
  }
  void dispatchResponseErrorBloc({@required state}){
    blocs.responsesBloc.add(ResponseErrorEvent(state: state));
  }
}