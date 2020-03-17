import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/action_button_navigation_bar_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/bottomMainBarWidgets/main_floating_action_button_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/app/body_app_widget.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/pagesWidgets/app/header_app_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultBottomBarController(
      dragLength: 500,
      snap: true,
      child: Page()
    );
  }
}

class Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (BuildContext context, AuthState state) {
        if(state is AuthCompletedState) {
          return Scaffold(
            extendBody: true,
            appBar: HeaderAppWidget(),
            body: BodyAppWidget(),
            floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
            floatingActionButton: MainFloatingActionButtonWidget(),
            bottomNavigationBar: ActionButtonNavigationBarWidget(),
          );
        } else if(state is NeedAuthState){
          return AuthPage();
        } else {
          return Container(child: Center(child: Text('Что-то пошло не так'),),);
        }
      },
    );
  }
}