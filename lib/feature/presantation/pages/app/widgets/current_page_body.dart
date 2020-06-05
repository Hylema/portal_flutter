import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_page.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPageBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Map _pageOptions = {
      MAIN_PAGE_INDEX_NUMBER: {
        PAGE: MainPage()
      },
      NEWS_PAGE_INDEX_NUMBER: {
        PAGE: Scrollbar(
          child: NewsPortalPage(),
        )
      },
      PROFILE_PAGE_INDEX_NUMBER: {
        PAGE: ProfilePage()
      },
      BIRTHDAY_PAGE_INDEX_NUMBER: {
        PAGE: Scrollbar(
          child: BirthdayPage(),
        )
      },
      VIDEO_PAGE_INDEX_NUMBER: {
        PAGE: Scrollbar(
          child: VideoGalleryPage(),
        )
      },
      POLLS_PAGE_INDEX_NUMBER: {
        PAGE: PollsPage()
      },
      PHONE_BOOK_PAGE_INDEX_NUMBER: {
        PAGE: PhoneBookPage()
      },
    };

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: _pageOptions[state.index][PAGE],
          );
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