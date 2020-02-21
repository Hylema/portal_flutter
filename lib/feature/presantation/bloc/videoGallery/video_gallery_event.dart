import 'package:meta/meta.dart';

@immutable
abstract class VideoGalleryEvent {}

class GetVideos extends VideoGalleryEvent {
  final pageIndex;
  final pageSize;

  GetVideos({this.pageIndex, this.pageSize});
}
