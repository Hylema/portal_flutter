import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class VideoGallery extends Equatable {
  final videos;

  VideoGallery({
    @required this.videos,
  }) : super([videos]);
}