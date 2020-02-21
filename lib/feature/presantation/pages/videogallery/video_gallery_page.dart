import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/videoGallery/video_gallery_items_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double lineValue = 0;

class VideoGalleryPage extends StatefulWidget {
  VideoGalleryPageState createState() => VideoGalleryPageState();
}

class VideoGalleryPageState extends State<VideoGalleryPage> {

  @override
  void initState(){
    super.initState();

  }

  void dispatchGetVideosFromNetwork(){
    context.bloc<VideoGalleryBloc>().add(GetVideos(pageSize: 15, pageIndex: 1));
  }

  Widget build(BuildContext context) {
    return BlocConsumer<VideoGalleryBloc, VideoGalleryState>(
      builder: (context, state) {
        if (state is EmptyVideoGalleryState) {}
        else if (state is LoadingVideoGalleryState) {}
        else if (state is LoadedVideoGalleryState) {
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
  ScrollController _scrollController = new ScrollController();
  BouncingScrollPhysics _bouncingScrollPhysics = new BouncingScrollPhysics();

  var videos;

  @override
  void initState() {
    videos = widget.videos;

    if (_scrollController.keepScrollOffset) {
      print('1');
      _scrollController.addListener(() {
        setState(() {
          lineValue = (-_scrollController.offset/130);
        });
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: Stack(
          children: <Widget>[
            SizedBox(
              height: 4,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                    Color.fromRGBO(238, 0, 38, 1)
                ),
                value: lineValue,
                backgroundColor: Colors.white,
              ),
            ),
            CustomScrollView(
              physics: _bouncingScrollPhysics,
              controller: _scrollController,
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, index){
                    return BuildVideo(
                        videoData: videos[index]
                    );
                  },
                      childCount: videos.length
                  ),
                ),
              ],
            ),
          ],
        )
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