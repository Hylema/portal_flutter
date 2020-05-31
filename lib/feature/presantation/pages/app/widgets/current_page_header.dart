import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/filter/birthday_page_filter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/filter/main_page_filter.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/widgets/news_portal_model_sheet_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/polls/archive_polls_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/video_gallery_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CurrentPageHeader extends StatelessWidget with PreferredSizeWidget{
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    List<Widget> _headerOptions = [
      HeaderAppBar(
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
                  Navigator.push(context, ScaleRoute(page: MainPageFilter()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppBar(
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
      HeaderAppBar(
        title: 'Профиль',
      ),
      HeaderAppBar(
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
                  Navigator.push(context, ScaleRoute(page: BirthdayPageFilter()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppBar(
        title: 'Опросы',
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, SlideRightRoute(page: ArchivePollsPage()));
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
      HeaderAppBar(
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
    ];

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if (state is LoadedSelectedIndexState) {
          return _headerOptions[state.index];
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