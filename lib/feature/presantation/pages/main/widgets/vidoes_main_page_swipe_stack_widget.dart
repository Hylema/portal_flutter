import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/widgets/video_gallery_item_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class VideosMainPageSwipeStackWidget extends StatelessWidget {
  final VideoGalleryBloc bloc;
  VideosMainPageSwipeStackWidget({@required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VideoGalleryBloc, VideoGalleryState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is EmptyVideoGalleryState) {}
        else if (state is LoadingVideoGalleryState) {}
        else if (state is LoadedVideoGalleryState) {
          return VideoGallerySwipeBody(listModels: state.listModels);
        } else if (state is ErrorVideoGalleryState) {}
        return Container();
      },
      listener: (context, state) {},
    );
  }
}

@immutable
class VideoGallerySwipeBody extends StatelessWidget {
  final List<VideosGalleryModel> listModels;
  VideoGallerySwipeBody({@required this.listModels});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height/3.3,
        child: Swiper(
          autoplay: true,
          autoplayDelay: 7000,
          itemBuilder: (BuildContext context, int index) {
            return VideoGalleryItemWidget(videoData: listModels[index]);
          },
          itemCount: listModels.length,
          itemWidth: MediaQuery.of(context).size.width / 1.2,
          viewportFraction: 0.8,
          layout: SwiperLayout.STACK,
        )
    );
  }
}
