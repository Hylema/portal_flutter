import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page_super_visor.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pickersModels/date_picker_birthday_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

BirthdayParams params;
BirthdayParams oldParams;

class AppPageViewModel extends BaseViewModel {

  AppPageViewModel({@required NavigationBarBloc navigationBar}){

    hideButtonController.addListener(() {
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if(isVisible) navigationBar.add(hideNavigationBarEvent());
        isVisible = false;
      }
      if (hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if(!isVisible) navigationBar.add(showNavigationBarEvent());
        isVisible = true;
      }
    });

    GlobalState.hideAppNavigationBarController = hideButtonController;
  }

  ScrollController hideButtonController = new ScrollController();
  bool isVisible = true;
}