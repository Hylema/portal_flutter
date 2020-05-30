import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavigationAppBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SelectedIndexBloc, SelectedIndexState>(
      // ignore: missing_return
      builder: (context, state) {
        if(state is LoadedSelectedIndexState){
          return BottomNavigationBarWidgetStateBuilder(selectedIndex: state.index);
        }
      },
      listener: (context, state) {},
    );
  }
}

class BottomNavigationBarWidgetStateBuilder extends StatelessWidget {
  final selectedIndex;
  BottomNavigationBarWidgetStateBuilder({this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    List<Widget> items = List.generate(APP_BAR_ITEMS.length, (int index) {
      return BottomAppBarBuildItem(
        item: APP_BAR_ITEMS[index],
        index: index,
        selectedIndexBloc: context.bloc<SelectedIndexBloc>(),
        selectedIndex: selectedIndex,
      );
    });

    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [Expanded(child: Container(), flex: 1), ...items, Expanded(child: Container(), flex: 8,)],
        ),
      ),
      color: Colors.white,
    );
  }
}

class BottomAppBarBuildItem extends StatelessWidget {

  final item;
  final selectedIndex;
  final int index;
  final SelectedIndexBloc selectedIndexBloc;

  BottomAppBarBuildItem({
    @required this.item,
    @required this.selectedIndex,
    @required this.index,
    @required this.selectedIndexBloc
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 7,
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: () {
            selectedIndexBloc.add(UpdateIndexEvent(index: index));
            DefaultBottomBarController.of(context).close();
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                item['icon'],
                color: selectedIndex == index ?
                BOTTOM_NAVIGATION_BAR_SELECTED_COLOR :
                BOTTOM_NAVIGATION_BAR_DEFAULT_COLOR,
                height: BOTTOM_NAVIGATION_BAR_ICON_SIZE,
              ),
              AnimatedDefaultTextStyle(
                style: selectedIndex == index ?
                TextStyle(
                    color: BOTTOM_NAVIGATION_BAR_SELECTED_COLOR,
                    fontSize: BOTTOM_NAVIGATION_BAR_SELECTED_TEXT_SIZE
                ) :
                TextStyle(
                    color: BOTTOM_NAVIGATION_BAR_DEFAULT_COLOR,
                    fontSize: BOTTOM_NAVIGATION_BAR_TEXT_SIZE
                ),
                duration: Duration(milliseconds: 200),
                child: Text(
                  item['text'],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}