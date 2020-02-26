import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/video_gallery_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/videoGallery/video_gallery_items_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

double lineValue = 0;

bool loading = false;

class VideoGalleryPage extends StatefulWidget {
  VideoGalleryPageState createState() => VideoGalleryPageState();
}

class VideoGalleryPageState extends State<VideoGalleryPage> {

  @override
  void initState(){
    super.initState();

  }

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
  ScrollController _scrollController = new ScrollController();
  BouncingScrollPhysics _bouncingScrollPhysics = new BouncingScrollPhysics();

  var videos;
  bool userScroll = false;

  @override
  void initState() {
    videos = widget.videos;

    _scrollController.addListener(() {
      if (userScroll) {
        setState(() {
          lineValue = (-_scrollController.offset/130);
        });
      }
    });


    super.initState();
  }

  void dispatchGetVideosFromNetwork(){
    context.bloc<VideoGalleryBloc>().add(GetVideos(pageSize: 15, pageIndex: 1));
  }

  _refreshVideos(){
    setState(() {
      loading = true;
    });

    dispatchGetVideosFromNetwork();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        child: Scrollbar(
            child: Stack(
              children: <Widget>[
                SizedBox(
                    height: 4,
                    child: !loading ? LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          lineValue < 1
                              ? Color.fromRGBO(238, 0, 38, 0.4)
                              : Color.fromRGBO(238, 0, 38, 1)
                      ),
                      value: lineValue,
                      backgroundColor: Colors.white,
                    ) : LinearProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Color.fromRGBO(238, 0, 38, 1)
                      ),
                      backgroundColor: Colors.white,
                    )
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
        ),
        onNotification: (notification){
          if(notification is ScrollStartNotification) {
            if(_scrollController.offset.ceil() == 0){
              userScroll = true;
            }
          }
          else if(notification is ScrollEndNotification) userScroll = false;
          else if(notification is ScrollUpdateNotification) {
            if(notification.dragDetails == null && lineValue >= 1){
              _refreshVideos();
            }
          }
          return true;
        }
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