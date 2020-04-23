import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_page.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Map _pageOptions = {
      MAIN_PAGE_INDEX_NUMBER: {
        PAGE: BlocProvider<MainBloc>(
          create: (BuildContext context) => sl<MainBloc>(),
          child: MainPage(),
        ),
      },
      NEWS_PAGE_INDEX_NUMBER: {
        PAGE: BlocProvider<NewsPortalBloc>(
          create: (BuildContext context) => sl<NewsPortalBloc>(),
          child: NewsPortalPage(),
        ),
      },
//      PROFILE_PAGE_INDEX_NUMBER: {
//        PAGE: BlocProvider<ProfileBloc>(
//          create: (BuildContext context) => sl<ProfileBloc>(),
//          child: ProfilePage(),
//        ),
//      },
      BIRTHDAY_PAGE_INDEX_NUMBER: {
        PAGE: BirthdayPage(),
      },
//      VIDEO_PAGE_INDEX_NUMBER: {
//        PAGE: BlocProvider<VideoGalleryBloc>(
//          create: (BuildContext context) => sl<VideoGalleryBloc>(),
//          child: VideoGalleryPage(),
//        ),
//      },
    };

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return BodyAppWidgetBuild(pages: _pageOptions[state.index]);
        } else {
          return Container(
            child: Center(
              child: Text('Неизвестная ошибка'),
            ),
          );
        }
      },
      listener: (context, state) {},
    );
  }
}

class BodyAppWidgetBuild extends StatelessWidget {

  final Map pages;
  BodyAppWidgetBuild({@required this.pages}) {
    assert(pages != null);
  }

  @override
  Widget build(BuildContext context) {
//    return Scrollbar(
//      child: pages[PAGE]
//    );


    return Column(
      children: <Widget>[
        Expanded(
            child: pages[PAGE],
        ),
        SizedBox(
          height: BOTTOM_NAVIGATION_BAR_HEIGHT + 10,
        ),
      ],
    );
  }
}
//);