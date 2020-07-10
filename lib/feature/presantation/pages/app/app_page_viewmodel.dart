import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:stacked/stacked.dart';

BirthdayParams params;
BirthdayParams oldParams;

class AppPageViewModel extends BaseViewModel {

  final NavigationBarBloc navigationBar;
  Orientation orientation;
  AppPageViewModel({
    @required this.navigationBar,
    @required this.orientation,
  }){


    GlobalState.hideAppNavigationBarController = hideButtonController;
  }

  void onModelReady() {
    hideButtonController.addListener(() {
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if(isVisible) {
          print('HIDE!!!!!!!!!!!!!!!!!!!!!!!');
          navigationBar.add(HideNavigationBarEvent());
        }
        offset = hideButtonController.offset.ceil();
        isVisible = false;
      }
      if (hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
        if(!isVisible && (offset - hideButtonController.offset.ceil()) > 10) {
          if(Orientation.portrait == orientation){
            print('SHOW!!!!!!!!!!!!!!!!!!!!!!!$orientation');
            navigationBar.add(ShowNavigationBarEvent());
          }
          isVisible = true;
        }
      }
    });
  }

  void setOrientation(Orientation newOrientation) {
    orientation = newOrientation;
  }

  ScrollController hideButtonController = new ScrollController();
  bool isVisible = true;
  int offset = 0;
}