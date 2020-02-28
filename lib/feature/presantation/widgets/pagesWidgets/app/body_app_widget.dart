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
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BodyAppWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Map _pageOptions = {
      MAIN_PAGE_NUMBER: {
        PAGE: MainPage(),
        UPDATE_HEADER: true,
        UPDATE_FOOTER: false,
      },
      NEWS_PAGE_NUMBER: {
        PAGE: NewsPortalPage(),
        UPDATE_HEADER: true,
        UPDATE_FOOTER: false,
      },
      PROFILE_PAGE_NUMBER: {
        PAGE: ProfilePage(),
        UPDATE_HEADER: true,
        UPDATE_FOOTER: false,
      },
      BIRTHDAY_PAGE_NUMBER: {
        PAGE: BirthdayPage(),
        UPDATE_HEADER: true,
        UPDATE_FOOTER: false,
      },
      VIDEO_PAGE_NUMBER: {
        PAGE: VideoGalleryPage(),
        UPDATE_HEADER: true,
        UPDATE_FOOTER: false,
      },
    };

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return BodyAppWidgetBuild(page: _pageOptions[state.index]);
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

  final Map page;
  BodyAppWidgetBuild({@required this.page}){
    assert(page != null);
  }

  RefreshController _refreshController = new RefreshController();

  @override
  Widget build(BuildContext context) {

    print('page ============= $page');

    return SmartRefresher(
        enablePullUp: page[UPDATE_FOOTER],
        enablePullDown: page[UPDATE_HEADER],
        header: WaterDropMaterialHeader(
          backgroundColor: Color.fromRGBO(238, 0, 38, 1),
          color: Colors.white,
          distance: 30,
        ),
        footer: ClassicFooter(),
        controller: _refreshController,
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                page[PAGE],
                SizedBox(
                  height: BOTTOM_NAVIGATION_BAR_HEIGHT,
                )
              ]),
            )
          ],
        )
    );
  }
}