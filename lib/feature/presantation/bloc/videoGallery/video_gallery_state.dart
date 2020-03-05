import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoGalleryState extends Equatable{
  VideoGalleryState([List props = const <dynamic>[]]) : super(props);
}

class EmptyVideoGalleryState extends VideoGalleryState {}
class LoadingVideoGalleryState extends VideoGalleryState {}
class NeedAuthVideoGalleryState extends VideoGalleryState {}
class LoadedVideoGalleryState extends VideoGalleryState {
  final VideosGalleryModel model;

  LoadedVideoGalleryState({@required this.model}) : super([model]);
}
class ErrorVideoGalleryState extends VideoGalleryState {
  final String message;

  ErrorVideoGalleryState({@required this.message}) : super([message]);
}
