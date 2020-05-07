import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/error/failure.dart';
import 'package:flutter_architecture_project/core/mixins/bloc_helper.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/domain/params/videoGallery/video_gallery_params.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/birthday/birthday_repository_interface.dart';
import 'package:flutter_architecture_project/feature/domain/repositoriesInterfaces/videoGallery/video_gallery_repository_interface.dart';
import './bloc.dart';

class VideoGalleryBloc extends Bloc<VideoGalleryEvent, VideoGalleryState>{
  final IVideoGalleryRepository repository;
  final NetworkInfo networkInfo;

  VideoGalleryBloc({@required this.repository, @required this.networkInfo});

  @override
  VideoGalleryState get initialState => EmptyVideoGalleryState();

  VideoGalleryParams _params = VideoGalleryParams(
      pageIndex: 1,
      pageSize: 10,
  );

  @override
  Stream<VideoGalleryState> mapEventToState(
    VideoGalleryEvent event,
  ) async* {
    final currentState = state;

    if(await networkInfo.isConnected){
      if (event is UpdateVideosEvent)
        yield* _update(event: event);

      else if(event is FetchVideosEvent && !_hasReachedMax(currentState))
        yield* _fetch(event: event);
    } else {
      throw NetworkException();
    }
  }

  Stream<VideoGalleryState> _update({@required VideoGalleryEvent event}) async*{
    _params.pageIndex = 1;

    List<VideosGalleryModel> repositoryResult =
    await repository.updateVideos(params: _params);

    yield LoadedVideoGalleryState(listModels: repositoryResult, hasReachedMax: false);
  }

  Stream<VideoGalleryState> _fetch({@required VideoGalleryEvent event}) async* {
    final currentState = state;

    _params.pageIndex += 1;
    if(currentState is LoadedVideoGalleryState){

      List<VideosGalleryModel> repositoryResult =
      await repository.fetchVideos(params: _params);

      yield repositoryResult.isEmpty
          ? currentState.copyWith(hasReachedMax: true)
          : LoadedVideoGalleryState(
        listModels: currentState.listModels + repositoryResult,
        hasReachedMax: false,
      );
    }
  }

  bool _hasReachedMax(VideoGalleryState state) =>
      state is LoadedVideoGalleryState && state.hasReachedMax;
}

