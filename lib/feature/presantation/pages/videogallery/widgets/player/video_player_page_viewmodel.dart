import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:stacked/stacked.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPageViewModel extends BaseViewModel {
  final VideosGalleryModel videoData;

  VideoPlayerPageViewModel({@required this.videoData}) {
    controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId("${videoData.videoUrl}"),
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  bool playerReady = false;
  double volume = 100;

  YoutubePlayerController controller;

  void playOrPause() {
    if(playerReady) {
      if(controller.value.isPlaying) controller.pause();
      else controller.play();
    }

    notifyListeners();
  }

  void changeVolume(newValue) {
    if(playerReady) {
      volume = newValue;
      controller.setVolume(volume.round());
    }

    notifyListeners();
  }
}