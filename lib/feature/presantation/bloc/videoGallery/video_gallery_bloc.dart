import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/error/messages.dart';
import 'package:flutter_architecture_project/feature/domain/usecases/videoGallery/get_video_gallery_from_network.dart';
import './bloc.dart';

class VideoGalleryBloc extends Bloc<VideoGalleryEvent, VideoGalleryState> {

  final GetVideoGalleryFromNetwork _getVideoGalleryFromNetwork;

  VideoGalleryBloc({
    @required GetVideoGalleryFromNetwork getVideoGalleryFromNetwork,
  }) :  assert(getVideoGalleryFromNetwork != null),
        _getVideoGalleryFromNetwork = getVideoGalleryFromNetwork;

  @override
  VideoGalleryState get initialState => EmptyVideoGalleryState();

  @override
  Stream<VideoGalleryState> mapEventToState(
    VideoGalleryEvent event,
  ) async* {
    if(event is GetVideos){
      yield* _eitherLoadedOrErrorState(
          either: await _getVideoGalleryFromNetwork(
              VideoGalleryParams(
                  pageIndex: event.pageIndex,
                  pageSize: event.pageSize
              )
          )
      );
    }
  }

  Stream<VideoGalleryState> _eitherLoadedOrErrorState({
    Either either,
  }) async* {
    yield either.fold(
          (failure){
            if(failure is AuthFailure){
              return NeedAuthVideoGalleryState();
            }
        return ErrorVideoGalleryState(message: mapFailureToMessage(failure));
      },
          (model){
        return LoadedVideoGalleryState(model: model);
      },
    );
  }
}
