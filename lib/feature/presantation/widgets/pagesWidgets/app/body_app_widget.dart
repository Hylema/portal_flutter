import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BodyAppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Map _pageOptions = {
      MAIN_PAGE_NUMBER: {
        CURRENT_PAGE: MainPage(),
      },
      NEWS_PAGE_NUMBER: {
        CURRENT_PAGE: NewsPortalPage(),
      },
      PROFILE_PAGE_NUMBER: {
        CURRENT_PAGE: ProfilePage(),
      },
      BIRTHDAY_PAGE_NUMBER: {
        CURRENT_PAGE: BirthdayPage(),
      },
      VIDEO_PAGE_NUMBER: {
        CURRENT_PAGE: VideoGalleryPage(),
      },
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
    return Column(
      children: <Widget>[
        Expanded(
            child: pages[CURRENT_PAGE]
        ),
        Container(
          height: BOTTOM_NAVIGATION_BAR_HEIGHT + 10,
        ),
      ],
    );
  }
}
//);