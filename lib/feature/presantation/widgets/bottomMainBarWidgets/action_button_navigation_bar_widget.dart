import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/bottom_navigation_bar_widget.dart';

class ActionButtonNavigationBarWidget extends StatelessWidget {

  ActionButtonNavigationBarWidget({this.selectedIndex, this.updateIndex});

  final selectedIndex;
  final updateIndex;

  @override
  Widget build(BuildContext context) {
    final String path = 'assets/icons/';

    final _bottomAppBarItem = [
      {
        'iconData': '${path}home.png',
        'text': 'Главная',
      },
      {
        'iconData': '${path}news.png',
        'text': 'Новости',
      },
    ];
    final _expandedHeight = 520.0;
    final _expandableAppBarItem = [
      {
        'icon': '${path}profile.png',
        'text': 'Профиль',
      },
      {
        'icon': '${path}birthday.png',
        'text': 'Дни рождения'
      },
      {
        'icon': '${path}polls.png',
        'text': 'Опросы'
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

    return BottomExpandableAppBar(
      //bottomOffset: 120,
      expandedHeight: _expandedHeight,
      horizontalMargin: 0,
      shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
          StadiumBorder(
              side: BorderSide()
          )
      ),
      expandedBackColor: Colors.white,
      expandedBody: Padding(
        padding: EdgeInsets.only(top: 30, bottom: 30),
        child: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                int _indexForBar = index + 2;

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
                    updateIndex(_indexForBar);
                  },
                );
              },
                childCount: _expandableAppBarItem.length,
              ),
            ),
          ],
        ),
      ),
      bottomAppBarBody: BottomNavigationBarWidget(
          color: Colors.grey,
          selectedColor: Color.fromRGBO(238, 0, 38, 1),
          notchedShape: CircularNotchedRectangle(),
          items: _bottomAppBarItem,
          onTabSelected: updateIndex,
          selectedIndex: selectedIndex
      ),
    );
  }
}