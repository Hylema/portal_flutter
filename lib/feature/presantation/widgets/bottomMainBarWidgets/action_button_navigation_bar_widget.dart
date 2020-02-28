import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/bottom_navigation_bar_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ActionButtonNavigationBarWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final double _expandedHeight = 420.0;
    final double _marginPanel = 20.0;

    return BottomExpandableAppBar(
      //bottomOffset: 120,
      expandedHeight: _expandedHeight,
      horizontalMargin: _marginPanel,
      shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          StadiumBorder(
              side: BorderSide()
          )
      ),
      expandedBackColor: Colors.white,
      expandedBody: BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
        builder: (context, state) {
          if(state is LoadedSelectedIndexState){
            return BottomExpandableAppBarBuilder(selectedIndex: state.index);
          } else {
            return Container();
          }
        },
        listener: (context, state) {},
      ),
      bottomAppBarBody: BottomNavigationBarWidget(),
    );
  }
}

class BottomExpandableAppBarBuilder extends StatelessWidget {
  final selectedIndex;
  BottomExpandableAppBarBuilder({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final String path = 'assets/icons/';

    final _expandableAppBarItem = [
      {
        'icon': '${path}birthday.png',
        'text': 'Дни рождения'
      },
      {
        'icon': '${path}videoGallery.png',
        'text': 'Видеогалерея'
      },
      {
        'icon': '${path}phonebook.png',
        'text': 'Телефонный справочник'
      },
      {
        'icon': '${path}calendarEvents.png',
        'text': 'Календарь событий'
      },
      {
        'icon': '${path}negotiationReservation.png',
        'text': 'Бронирование переговорных'
      },
      {
        'icon': '${path}applications.png',
        'text': 'Заявки'
      },
      {
        'icon': '${path}сorporateDocuments.png',
        'text': 'Корпоративные документы'
      },
    ];

    void dispatchUpdateIndex(index){
      context.bloc<SelectedIndexBloc>().add(UpdateIndexEvent(index: index));
    }

    return Padding(
      padding: EdgeInsets.only(top: 30, bottom: 30),
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              int _indexForBar = index + 4;

              return ListTile(
                leading: Padding(
                  padding: EdgeInsets.all(15),
                  child: Image.asset(
                    _expandableAppBarItem[index]['icon'],
                    color: _indexForBar == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey[800],
                  ),
                ),
                title: Text(
                    _expandableAppBarItem[index]['text'],
                    style: TextStyle(
                        color: _indexForBar == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey[800]
                    )
                ),
                onTap: (){
                  DefaultBottomBarController.of(context).swap();
                  dispatchUpdateIndex(_indexForBar);
                },
              );
            },
              childCount: _expandableAppBarItem.length,
            ),
          ),
        ],
      ),
    );
  }
}
