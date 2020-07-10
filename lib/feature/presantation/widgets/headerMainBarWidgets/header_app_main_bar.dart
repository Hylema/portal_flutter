import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_architecture_project/core/global_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stacked/stacked.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget{

  HeaderAppBar({
    this.titleColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.title,
    this.titleWidget,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.leading,
    this.backButtonColor = Colors.black,
    this.customNavigation,
  });

  final Color titleColor;
  final Color backgroundColor;
  final Color backButtonColor;
  final String title;
  final Widget titleWidget;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final Widget leading;
  final GlobalKey<NavigatorState> customNavigation;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);
  double toolbarHeight = 56.0;


  double oldValue;

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<NavigationBarBloc, NavigationBarState>(
      builder: (context, state) {
        bool visible = true;

        if(state is InitialNavigationBarState){
          visible = state.isVisible;
        }

        print('titleWidget --================== $titleWidget');

        return AppBar(
            automaticallyImplyLeading: automaticallyImplyLeading,
            backgroundColor: backgroundColor,
            title: titleWidget != null ? titleWidget : title != null ? Text(
              title,
              style: TextStyle(color: titleColor),
            ) : null,
            actionsIconTheme: IconThemeData(color: Colors.black),
            iconTheme: IconThemeData(color: Colors.black),
            actions: actions,
            centerTitle: true,
//            leading: leading ?? automaticallyImplyLeading ? IconButton(
//              icon: Icon(Icons.arrow_back, color: backButtonColor),
//              onPressed: () => customNavigation == null ? Navigator.of(context).pop() : customNavigation.currentState.pop(),
//            ) : null
        );

        return AnimatedCrossFade(
          crossFadeState: visible ? CrossFadeState.showFirst : CrossFadeState.showSecond,
          //alwaysIncludeSemantics: true,
          duration: Duration(milliseconds: 200),
          firstChild: AppBar(
              automaticallyImplyLeading: automaticallyImplyLeading,
              backgroundColor: backgroundColor,
              title: title != null ? Text(
                title,
                style: TextStyle(color: titleColor),
              ) : null,
              actionsIconTheme: IconThemeData(color: Colors.black),
              actions: actions,
              centerTitle: true,
              leading: leading ?? automaticallyImplyLeading ? IconButton(
                icon: Icon(Icons.arrow_back, color: backButtonColor),
                onPressed: () => customNavigation == null ? Navigator.of(context).pop() : customNavigation.currentState.pop(),
              ) : null
          ),
          secondChild: SizedBox(height: null),
        );
        return AnimatedOpacity(
          alwaysIncludeSemantics: true,
          duration: Duration(milliseconds: 200),
          child: AppBar(
              automaticallyImplyLeading: automaticallyImplyLeading,
              backgroundColor: backgroundColor.withOpacity(visible ? 1 : 0.1),
              elevation: 0,
              titleSpacing: 0,
              bottomOpacity: 0,
              toolbarOpacity: 0,
              title: title != null ? Text(
                title,
                style: TextStyle(color: titleColor),
              ) : null,
              actionsIconTheme: IconThemeData(color: Colors.black),
              actions: actions,
              centerTitle: true,
              leading: leading ?? automaticallyImplyLeading ? IconButton(
                icon: Icon(Icons.arrow_back, color: backButtonColor),
                onPressed: () => customNavigation == null ? Navigator.of(context).pop() : customNavigation.currentState.pop(),
              ) : null
          ),
          opacity: visible ? 1 : 0.1,
        );
      },
      listener: (context, state) {},
    );
  }
}

//class TestViewModelBuilder extends BaseViewModel {
//  double toolbarHeight = 56.0;
//  int currentScrollHeight;
//  bool hide = true;
//  bool currentScrollHeightSet = false;
//
//  TestViewModelBuilder(){
//    ScrollController hideButtonController = GlobalState.hideAppNavigationBarController;
//    hideButtonController.addListener(() {
//      if (hideButtonController.position.userScrollDirection == ScrollDirection.reverse) {
//        if(!currentScrollHeightSet){
//          currentScrollHeight = hideButtonController.offset.ceil();
//        }
//
//        toolbarHeight = (currentScrollHeight - hideButtonController.offset.ceil()).toDouble();
//
//        print('TestViewModelBuilder!!!!!!!!!!!!!!!!!!!!!!! $toolbarHeight');
//
//        notifyListeners();
//      }
//      if (hideButtonController.position.userScrollDirection == ScrollDirection.forward) {
//        hide = false;
//      }
//    });
//  }
//}