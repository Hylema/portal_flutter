import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/headerMainBarWidgets/header_app_main_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/newsPortal/news_portal_model_sheet_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/main_page_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_parameters.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderAppWidget extends StatelessWidget with PreferredSizeWidget{
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    List<Widget> _headerOptions = [
      HeaderAppMainBar(
        titleText: 'Главная',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, SlideRightRoute(page: MainPageParameters()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'Новости холдинга',
        action: <Widget>[
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
      HeaderAppMainBar(
        titleText: 'Профиль',
      ),
      HeaderAppMainBar(
        titleText: 'Дни рождения',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){
                  Navigator.push(context, SlideRightRoute(page: BirthdayPageParameters()));
                },
                icon: Image.asset(
                  'assets/icons/change.png',
                )
            ),
          ),
        ],
      ),
      HeaderAppMainBar(
        titleText: 'test',
      ),
      HeaderAppMainBar(
        titleText: 'Видеогалерея',
        action: <Widget>[
          Padding(
            padding: EdgeInsets.only(
                right: 15.0,
                top: 7,
                bottom: 7
            ),
            child: IconButton(
                onPressed: (){},
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