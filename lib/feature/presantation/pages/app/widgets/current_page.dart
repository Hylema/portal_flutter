import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/core/singleton_blocs.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page_super_visor.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/calendar/calendar_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/news_portal_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/phone_book_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/profile_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_page.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CurrentPage extends StatelessWidget {
  final getIt = GetIt.instance;

  @override
  Widget build(BuildContext context) {
    final SingletonBlocs singletonBlocs = getIt<SingletonBlocs>();

    BlocSupervisor.delegate = SupervisorAppPage(
        snackBar: Scaffold.of(context).showSnackBar,
        context: context
    );

    Map _pageOptions = {
      MAIN_PAGE_INDEX_NUMBER: MainPage(bloc: singletonBlocs.mainBloc),
      NEWS_PAGE_INDEX_NUMBER: NewsPortalPage(bloc: singletonBlocs.newsPortalBloc),
      PROFILE_PAGE_INDEX_NUMBER: ProfilePage(bloc: singletonBlocs.profileBloc),
      BIRTHDAY_PAGE_INDEX_NUMBER: BirthdayPage(bloc: singletonBlocs.birthdayBloc),
      VIDEO_PAGE_INDEX_NUMBER: VideoGalleryPage(bloc: singletonBlocs.videoGalleryBloc),
      POLLS_PAGE_INDEX_NUMBER: PollsPage(bloc: singletonBlocs.pollsBloc),
      PHONE_BOOK_PAGE_INDEX_NUMBER: PhoneBookPage(bloc: singletonBlocs.phoneBookBloc),
      CALENDAR_PAGE_INDEX_NUMBER: CalendarPage(),
      BOOKING_PAGE_INDEX_NUMBER: Scaffold(
        appBar: AppBar(title: Text('Бронирование переговорных'),),
        body: Center(child: Text('Эта страница в разработке'),),
      ),
      9: Scaffold(
        appBar: AppBar(title: Text('Заявки'),),
        body: Center(child: Text('На эту страницу нет макета'),),
      ),
      10: Scaffold(
        appBar: AppBar(title: Text('Корпоративные документы'),),
        body: Center(child: Text('На эту страницу нет макета'),),
      ),
    };

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: _pageOptions[state.index],
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