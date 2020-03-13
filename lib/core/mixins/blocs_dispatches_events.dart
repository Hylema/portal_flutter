import 'package:flutter/cupertino.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/mixins/blocs.dart';
import 'package:flutter_architecture_project/core/mixins/singleton.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/blocsResponses/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/fields/bloc.dart';
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
  void dispatchUpdateBirthday(){
    blocs.birthdayBloc.add(UpdateBirthdayEvent());
  }
  void dispatchLoadMoreBirthday(){
    blocs.birthdayBloc.add(LoadMoreBirthdayEvent());
  }
  void dispatchSetFilterBirthday({
    @required titleDate,
    fio,
    startDayNumber,
    endDayNumber,
    startMonthNumber,
    endMonthNumber,
  }){
    print('dispatchSetFilterBirthday=======================dispatchSetFilterBirthday');
    blocs.birthdayBloc.add(SetFilterBirthdayEvent(
      fio: fio,
      startDayNumber: startDayNumber,
      endDayNumber: endDayNumber,
      startMonthNumber: startMonthNumber,
      endMonthNumber: endMonthNumber,
        titleDate: titleDate
    ));
  }
  void dispatchResetFilterBirthday(){
    blocs.birthdayBloc.add(ResetFilterBirthdayEvent());
  }

  ///Responses
  void dispatchResponseSuccessBloc({@required state}){
    blocs.responsesBloc.add(ResponseSuccessEvent(state: state));
  }
  void dispatchResponseErrorBloc({@required state}){
    blocs.responsesBloc.add(ResponseErrorEvent(state: state));
  }
}