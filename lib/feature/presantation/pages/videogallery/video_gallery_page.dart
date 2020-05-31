import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/widgets/video_gallery_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

double lineValue = 0;

class VideoGalleryPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocConsumer<VideoGalleryBloc, VideoGalleryState>(
      builder: (context, state) {
        if (state is EmptyVideoGalleryState) {}
        else if (state is LoadingVideoGalleryState) {}
        else if (state is LoadedVideoGalleryState) {
          return VideoGalleryPageBody(listModels: state.listModels, hasReachedMax: state.hasReachedMax,);
        } else if (state is ErrorVideoGalleryState) {}
        return Container();
      },
      listener: (context, state) {},
    );
  }
}

class VideoGalleryPageBody extends StatelessWidget {
  final List<VideosGalleryModel> listModels;
  final bool hasReachedMax;

  VideoGalleryPageBody({@required this.listModels, @required this.hasReachedMax});

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      hasReachedMax: hasReachedMax,
      onRefresh: () => BlocProvider.of<VideoGalleryBloc>(context).add(UpdateVideosEvent()),
      onLoading: () => BlocProvider.of<VideoGalleryBloc>(context).add(FetchVideosEvent()),
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index){
              print(listModels[index].videoUrl);
              final _videoPlayerController1 = VideoPlayerController.network(
                  listModels[index].videoUrl);
              final _videoPlayerController2 = VideoPlayerController.network(
                  'https://www.sample-videos.com/video123/mp4/480/asdasdas.mp4');

//              return Container(height: MediaQuery.of(context).size.width, child: ChewieDemo(
//                  url: 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'
//              ),);
//              return VideoGalleryItemsWidget(
//                  videoData: listModels[index]
//              );
//            return ChewieListItem(videoPlayerController: _videoPlayerController1);

              return VideoGalleryItemWidget(videoData: listModels[index]);
            },
                childCount: listModels.length
            ),
          ),
        ],
      ),
    );
  }
}
