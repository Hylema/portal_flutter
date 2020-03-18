//import 'dart:async';
//import 'package:bloc/bloc.dart';
//import 'package:dartz/dartz.dart';
//import 'package:flutter_architecture_project/core/error/failure.dart';
//import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
//import './bloc.dart';
//
//class VideoGalleryBloc extends Bloc<VideoGalleryEvent, VideoGalleryState> with BlocHelper<VideoGalleryState>{
//
//  @override
//  VideoGalleryState get initialState => EmptyVideoGalleryState();
//
//  @override
//  Stream<VideoGalleryState> mapEventToState(
//    VideoGalleryEvent event,
//  ) async* {
//    if(event is GetVideos){
//      yield* _eitherLoadedOrErrorState(
//          either: await _getVideoGalleryFromNetwork(
//              VideoGalleryParams(
//                  pageIndex: event.pageIndex,
//                  pageSize: event.pageSize
//              )
//          )
//      );
//    }
//  }
//
//  Stream<VideoGalleryState> _eitherLoadedOrErrorState({
//    Either either,
//  }) async* {
//    yield either.fold(
//          (failure){
//            if(failure is AuthFailure){
//              return NeedAuthVideoGalleryState();
//            }
//        return ErrorVideoGalleryState(message: mapFailureToMessage(failure));
//      },
//          (model){
//        return LoadedVideoGalleryState(model: model);
//      },
//    );
//  }
//}
