import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/data/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:stacked/stacked.dart';

BirthdayParams params;
BirthdayParams oldParams;

class AppPageViewModel extends BaseViewModel {

  AppPageViewModel({@required NavigationBarBloc navigationBar}){

    hideButtonController.addListener(() {
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if(isVisible) navigationBar.add(HideNavigationBarEvent());
        print('isNotVisible');
        isVisible = false;
      }
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if(!isVisible) navigationBar.add(ShowNavigationBarEvent());
        print('isVisible');
        isVisible = true;
      }
    });

    GlobalState.hideAppNavigationBarController = hideButtonController;
  }

  ScrollController hideButtonController = new ScrollController();
  bool isVisible = true;
}