import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/appBottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpendableNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return BottomExpandableAppBar(
      //bottomOffset: 120,
      //appBarHeight: isVisible ? 60 : animation.value.toDouble(),
        expandedHeight: EXPANDABLE_APP_BAR_HEIGHT,
        horizontalMargin: EXPANDABLE_APP_BAR_HORIZONTAL_MARGIN,
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
              return ExpendableNavigationBarBuildItem(selectedIndex: state.index);
            } else {
              return Container();
            }
          },
          listener: (context, state) {},
        ),
        bottomAppBarBody: BottomNavigationAppBar()
    );
  }
}

class ExpendableNavigationBarBuildItem extends StatelessWidget {
  final selectedIndex;
  ExpendableNavigationBarBuildItem({this.selectedIndex});

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(left: 15, top: 15),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              int _indexForBar = index + 3;
              double size = selectedIndex == index + 3 ? BOTTOM_NAVIGATION_BAR_SELECTED_TEXT_SIZE : BOTTOM_NAVIGATION_BAR_TEXT_SIZE;

              return ListTile(
                dense: true,
                leading: Image.asset(
                  EXPANDABLE_APP_BAR_ITEMS[index]['icon'],
                  height: BOTTOM_NAVIGATION_BAR_ICON_SIZE,
                  color: _indexForBar == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey,
                ),
                title: Text(
                    EXPANDABLE_APP_BAR_ITEMS[index]['text'],
                    style: TextStyle(
                        color: _indexForBar == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey,
                      fontSize: size
                    )
                ),
                onTap: (){
                  DefaultBottomBarController.of(context).swap();
                  context.bloc<SelectedIndexBloc>().add(UpdateIndexEvent(index: _indexForBar));
                },
              );
            },
              childCount: EXPANDABLE_APP_BAR_ITEMS.length,
            ),
          ),
        ],
      ),
    );
  }
}


