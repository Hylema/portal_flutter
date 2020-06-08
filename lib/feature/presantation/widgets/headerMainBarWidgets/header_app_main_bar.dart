import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget{

  HeaderAppBar({
    this.titleColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
    this.leading,
    this.backButtonColor = Colors.white,
    this.customNavigation,
  });

  final Color titleColor;
  final Color backgroundColor;
  final Color backButtonColor;
  final String title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;
  final Widget leading;
  final GlobalKey<NavigatorState> customNavigation;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  double oldValue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading,
      backgroundColor: backgroundColor,
      elevation: 1.0,
      title: Text(
        title ?? '',
        style: TextStyle(color: titleColor),
      ),
      actionsIconTheme: IconThemeData(color: Colors.black),
      actions: actions,
      centerTitle: true,
      leading: leading ?? automaticallyImplyLeading ? IconButton(
        icon: Icon(Icons.arrow_back, color: backButtonColor),
        onPressed: () => customNavigation == null ? Navigator.of(context).pop() : customNavigation.currentState.pop(),
      ) : null
    );
  }
}