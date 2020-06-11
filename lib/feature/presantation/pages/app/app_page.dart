import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/animation/fade_animation.dart';
import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page_super_visor.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page_viewmodel.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/widgets/current_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/widgets/current_page_header.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/appBottomNavigationBar/expandeble_navigation_bar.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/appBottomNavigationBar/floating_action_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class AppPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppPageViewModel>.nonReactive(
      builder: (context, model, child) => DefaultBottomBarController(
          dragLength: 500,
          snap: true,
          child: Scaffold(
              extendBody: true,
              body: CurrentPage(),
              floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
              floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
              floatingActionButton: BlocConsumer<NavigationBarBloc, NavigationBarState>(
                // ignore: missing_return
                builder: (context, state) {
                  if(state is InitialNavigationBarState){

                    return state.isVisible
                        ? MainFloatingActionButtonWidget()
                        : Container();
                  }
                },
                listener: (context, state) {},
              ),
              bottomNavigationBar: BlocConsumer<NavigationBarBloc, NavigationBarState>(
                // ignore: missing_return
                builder: (context, state) {
                  if(state is InitialNavigationBarState){

//                    return AnimatedCrossFade(
//                      crossFadeState: state.isVisible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
//                      //alwaysIncludeSemantics: true,
//                      duration: Duration(milliseconds: 200),
//                      firstChild: ExpendableNavigationBar(),
//                      secondChild: SizedBox(height: 0),
//                    );

                    return IgnorePointer(
                      ignoring: !state.isVisible,
                      child: AnimatedOpacity(
                        alwaysIncludeSemantics: true,
                        duration: Duration(milliseconds: 200),
                        child: ExpendableNavigationBar(),
                        opacity: state.isVisible ? 1 : 0,
                      ),
                    );
                  }
                },
                listener: (context, state) {},
              ),
          )
      ),
      viewModelBuilder: () => AppPageViewModel(
        navigationBar: BlocProvider.of<NavigationBarBloc>(context),
      ),
    );
  }
}
