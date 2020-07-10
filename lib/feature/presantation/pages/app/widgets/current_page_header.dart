import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/widgets/current_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/filter/birthday_page_filter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/filter/main_page_filter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_model_sheet_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/archive_polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPageHeader extends StatelessWidget with PreferredSizeWidget{

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    Map _headerOptions = {
      MAIN_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Главная',
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(context, FadeRoute(page: MainPageFilter()));
                  },
                  icon: Image.asset(
                    'assets/icons/change.png',
                  )
              ),
            ),
          ],
        ),
      },
      NEWS_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Новости холдинга',
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: (){
                    showModalSheet(context);
                  },
                  icon: Image.asset(
                    'assets/icons/change.png',
                  )
              ),
            ),
          ],
        ),
      },
      PROFILE_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Профиль',
        ),
      },
      BIRTHDAY_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Дни рождения',
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(context, EnterExitRoute(exitPage: AppPage(),enterPage: BirthdayPageFilter()));
                  },
                  icon: Image.asset(
                    'assets/icons/change.png',
                  )
              ),
            ),
          ],
        ),
      },
      VIDEO_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
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
                    //Navigator.push(context, ScaleRoute(page: VideoGalleryParameters()));
                  },
                  icon: Image.asset(
                    'assets/icons/change.png',
                  )
              ),
            ),
          ],
        ),
      },
      POLLS_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Опросы',
          actions: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 7,
                  bottom: 7
              ),
              child: IconButton(
                  onPressed: (){
                    Navigator.push(context, EnterExitRoute(exitPage: AppPage(),enterPage: ArchivePollsPage()));
                  },
                  icon: Image.asset(
                    'assets/icons/archivePolls.png',
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  right: 15.0,
                  top: 7,
                  bottom: 7
              ),
//            child: IconButton(
////                onPressed: (){
////                  Navigator.push(context, ScaleRoute(page: BirthdayPageParameters()));
////                },
//                icon: Image.asset(
//                  'assets/icons/change.png',
//                )
//            ),
            ),
          ],
        ),
      },
      PHONE_BOOK_PAGE_INDEX_NUMBER: {
        PAGE: HeaderAppBar(
          title: 'Телефонный справочник',
        ),
      }
    };

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 200),
            child: _headerOptions[state.index][PAGE],
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