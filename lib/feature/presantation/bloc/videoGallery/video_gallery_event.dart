import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class VideoGalleryEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchVideosEvent extends VideoGalleryEvent {}
class UpdateVideosEvent extends VideoGalleryEvent {}
