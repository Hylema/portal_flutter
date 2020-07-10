import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/selected_index_state.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/appBottomNavigationBar/bottom_navigation_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/appBottomNavigationBar/expandebleNavigationBar/expandeble_navigation_bar_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpendableNavigationBar extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return OrientationBuilder(
      builder: (context, orientation) =>
          BottomExpandableAppBar(
            //bottomOffset: 120,
            //appBarHeight: isVisible ? 60 : animation.value.toDouble(),
              expandedHeight: Orientation.portrait == orientation ? EXPANDABLE_APP_BAR_HEIGHT : EXPANDABLE_APP_BAR_HEIGHT / 2,
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
                    return ExpendableNavigationBarBuildItem(
                        selectedIndex: state.index,
                        orientation: orientation
                    );
                  } else {
                    return Container();
                  }
                },
                listener: (context, state) {},
              ),
              bottomAppBarBody: BottomNavigationAppBar()
          )
    );
  }
}

class ExpendableNavigationBarBuildItem extends StatelessWidget {
  final int selectedIndex;
  final Orientation orientation;
  ExpendableNavigationBarBuildItem({
    @required this.selectedIndex,
    @required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    return Orientation.portrait == orientation ? Padding(
      padding: EdgeInsets.only(left: 15, top: 15),
      child: CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildBuilderDelegate((BuildContext context, int index){
              return ExpendableNavigationItem(
                index: index,
                selectedIndex: selectedIndex,
              );
            },
              childCount: EXPANDABLE_APP_BAR_ITEMS.length,
            ),
          ),
        ],
      ),
    ) : Padding(
      padding: EdgeInsets.only(left: 15, top: 15),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return ExpendableNavigationItem(
                      index: index,
                      selectedIndex: selectedIndex,
                    );
                  },
                    childCount: 4,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverList(
                  delegate: SliverChildBuilderDelegate((BuildContext context, int index){
                    return ExpendableNavigationItem(
                      index: index + 4,
                      selectedIndex: selectedIndex,
                    );
                  },
                    childCount: 4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


