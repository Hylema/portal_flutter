import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BottomNavigationBarWidgetState();
}

class BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      builder: (context, state) {
        if(state is LoadedSelectedIndexState){
          return BottomNavigationBarWidgetStateBuilder(selectedIndex: state.index);
        } else {
          return Container();
        }
      },
      listener: (context, state) {},
    );
  }
}

class BottomNavigationBarWidgetStateBuilder extends StatelessWidget {
  final selectedIndex;
  BottomNavigationBarWidgetStateBuilder({this.selectedIndex});

  final Color selectedColor = Color.fromRGBO(238, 0, 38, 1);
  final Color defaultColor = Colors.grey;

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
      {
        'iconData': '${path}profile.png',
        'text': 'Профиль',
      },
      {
        'iconData': '${path}polls.png',
        'text': 'Опросы'
      },
    ];

    void dispatchUpdateIndex(index){
      context.bloc<SelectedIndexBloc>().add(UpdateIndexEvent(index: index));
    }

    List<Widget> items = List.generate(_bottomAppBarItem.length, (int index) {
      return _buildTabItem(
          item: _bottomAppBarItem[index],
          index: index,
          dispatch: dispatchUpdateIndex
      );
    });

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: items,
        ),
      ),
      color: Colors.white,
    );
  }

  Widget _buildTabItem({
    item,
    int index,
    Function dispatch
  }) {
    Color color = selectedIndex == index ? selectedColor : defaultColor;
    return Expanded(
      child: SizedBox(
        height: BOTTOM_NAVIGATION_BAR_HEIGHT,
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            onTap: (){
              dispatch(index);
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  item['iconData'],
                  color: color,
                  height: 28.0,
                ),
                Text(
                  item['text'],
                  style: TextStyle(color: color),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}