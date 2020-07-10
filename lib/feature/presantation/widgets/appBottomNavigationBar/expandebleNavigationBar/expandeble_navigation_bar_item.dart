import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpendableNavigationItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  ExpendableNavigationItem({
    @required this.index,
    @required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    double size = selectedIndex == index + 3 ? BOTTOM_NAVIGATION_BAR_SELECTED_TEXT_SIZE : BOTTOM_NAVIGATION_BAR_TEXT_SIZE;

    return ListTile(
      dense: true,
      leading: Image.asset(
        EXPANDABLE_APP_BAR_ITEMS[index]['icon'],
        height: BOTTOM_NAVIGATION_BAR_ICON_SIZE,
        color: index + 3 == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey,
      ),
      title: Text(
          EXPANDABLE_APP_BAR_ITEMS[index]['text'],
          style: TextStyle(
              color: index + 3 == selectedIndex ? Color.fromRGBO(238, 0, 38, 1) : Colors.grey,
              fontSize: size
          )
      ),
      onTap: (){
        DefaultBottomBarController.of(context).swap();
        BlocProvider.of<SelectedIndexBloc>(context).add(UpdateIndexEvent(index: index + 3));
      },
    );
  }
}