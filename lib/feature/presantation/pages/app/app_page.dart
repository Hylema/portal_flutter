import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
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

class Page extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => PageState();
}

class PageState extends State<Page> {
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        if(state is Finish) {
          return Scaffold(
            extendBody: true,
            appBar: HeaderAppWidget(),
            body: BodyAppWidget(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: MainFloatingActionButtonWidget(),
            bottomNavigationBar: ActionButtonNavigationBarWidget(),
          );
        }
        return Container(child: Center(child: Text('Что-то пошло не так'),),);
      },
    );
  }
}