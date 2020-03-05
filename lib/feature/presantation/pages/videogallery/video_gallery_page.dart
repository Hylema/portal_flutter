import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/easy_refresh_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/videoGallery/video_gallery_items_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double lineValue = 0;

bool loading = false;

class VideoGalleryPage extends StatelessWidget {

  Widget build(BuildContext context) {
    return BlocConsumer<VideoGalleryBloc, VideoGalleryState>(
      builder: (context, state) {
        if (state is EmptyVideoGalleryState) {}
        else if (state is LoadingVideoGalleryState) {}
        else if (state is LoadedVideoGalleryState) {
          loading = false;
          return VideoGalleryPageBody(videos: state.model.videos);
        } else if (state is ErrorProfile) {}
        return Container();
      },
      listener: (context, state) {},
    );
  }
}

class VideoGalleryPageBody extends StatefulWidget {
  final videos;
  VideoGalleryPageBody({this.videos});

  @override
  State<StatefulWidget> createState() => VideoGalleryPageBodyState();
}

class VideoGalleryPageBodyState extends State<VideoGalleryPageBody>{

  bool userScroll = false;

  void dispatchGetVideosFromNetwork(){
    context.bloc<VideoGalleryBloc>().add(GetVideos(pageSize: 15, pageIndex: 1));
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      pageKey: VIDEO_PAGE,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index){
              return BuildVideo(
                  videoData: widget.videos[index]
              );
            },
                childCount: widget.videos.length
            ),
          ),
        ],
      ),
    );
  }
}

class BuildVideo extends StatelessWidget {
  final videoData;

  BuildVideo({
    this.videoData
  });

  @override
  Widget build(BuildContext context) {
    return VideoGalleryItemsWidget(videoData: videoData);
  }
}