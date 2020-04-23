import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/pageLoading/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/birthday/birthday_page_parameters.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/action_button_navigation_bar_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/main_floating_action_button_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/app/body_app_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/app/header_app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = SupervisorAppPage(
        snackBar: Scaffold.of(context).showSnackBar,
        blocAuth: BlocProvider.of<AuthBloc>(context),
        pageLoadingBloc: BlocProvider.of<PageLoadingBloc>(context),
        context: context
    );

    return DefaultBottomBarController(
      dragLength: 500,
      snap: true,
      child: Scaffold(
        extendBody: true,
        appBar: HeaderAppWidget(),
        body: BodyAppWidget(),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: MainFloatingActionButtonWidget(),
        bottomNavigationBar: ActionButtonNavigationBarWidget(),
      )
    );
  }
}

class SupervisorAppPage extends BlocDelegate {

  final Function snackBar;
  final AuthBloc blocAuth;
  final PageLoadingBloc pageLoadingBloc;
  final BuildContext context;

  SupervisorAppPage({
    @required this.snackBar,
    @required this.blocAuth,
    @required this.pageLoadingBloc,
    @required this.context
  });

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) async {
    super.onError(bloc, error, stacktrace);
    if(error is AuthException) {
      Navigator.pushNamed(context, '/auth');
      //Navigator.pushReplacementNamed(context, '/auth');
      return;
    } else if(error is ServerException){
      Navigator.pushNamed(context, '/auth');
      return;
    }


    int seconds;
    String errorMessage = error.toString();

    if(error is ServerException) errorMessage = error.message;
    if(error is NetworkException) errorMessage = error.message;

    final int errorMessageLength = errorMessage.length;

    if(errorMessageLength > 20 && errorMessageLength < 40) seconds = 3;
    else if(errorMessageLength > 40 && errorMessageLength < 60) seconds = 4;
    else if(errorMessageLength > 69 && errorMessageLength < 80) seconds = 5;
    else if(errorMessageLength > 80 && errorMessageLength < 100) seconds = 6;
    else if(errorMessageLength > 100 && errorMessageLength < 120) seconds = 7;
    else if(errorMessageLength > 120 && errorMessageLength < 140) seconds = 8;
    else if(errorMessageLength > 140 && errorMessageLength < 160) seconds = 9;
    else seconds = 15;

    snackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: seconds),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {},
          ),
        )
    );
  }
}