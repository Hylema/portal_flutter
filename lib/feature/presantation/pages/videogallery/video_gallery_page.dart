import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/models/videoGallery/video_gallery_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_shimmer.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/widgets/video_gallery_item_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/refreshLoaded/refresh_loaded_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

double lineValue = 0;

class VideoGalleryPage extends StatelessWidget {
  final VideoGalleryBloc bloc;
  VideoGalleryPage({@required this.bloc});

  Widget build(BuildContext context) {
    return BlocConsumer<VideoGalleryBloc, VideoGalleryState>(
      bloc: bloc,
      builder: (context, state) {
        Widget currentViewOnPage = BirthdayPageShimmer();

        if (state is EmptyVideoGalleryState) {}
        else if (state is LoadingVideoGalleryState) {}
        else if (state is LoadedVideoGalleryState) {
          currentViewOnPage =  VideoGalleryPageBody(listModels: state.listModels, hasReachedMax: state.hasReachedMax, bloc: bloc,);
        } else if (state is ErrorVideoGalleryState) {}


        return Scaffold(
          appBar: HeaderAppBar(
            title: 'Видеогалерея',
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    right: 15.0,
                    top: 7,
                    bottom: 7
                ),
                child: IconButton(
                    onPressed: (){
                      Navigator.push(context, ScaleRoute(page: VideoGalleryParameters()));
                    },
                    icon: Image.asset(
                      'assets/icons/change.png',
                    )
                ),
              ),
            ],
          ),
          body: Scrollbar(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 200),
              child: currentViewOnPage,
            ),
          )
        );
      },
      listener: (context, state) {},
    );
  }
}

class VideoGalleryPageBody extends StatelessWidget {
  final List<VideosGalleryModel> listModels;
  final bool hasReachedMax;
  final VideoGalleryBloc bloc;

  VideoGalleryPageBody({@required this.listModels, @required this.hasReachedMax, @required this.bloc});

  @override
  Widget build(BuildContext context) {
    return SmartRefresherWidget(
      enableControlLoad: true,
      enableControlRefresh: true,
      hasReachedMax: hasReachedMax,
      onRefresh: () => bloc.add(UpdateVideosEvent()),
      onLoading: () => bloc.add(FetchVideosEvent()),
      child: CustomScrollView(
        controller: GlobalState.hideAppNavigationBarController,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, index){
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
