import 'package:flutter/material.dart';

class HeaderAppBar extends StatelessWidget with PreferredSizeWidget{

  HeaderAppBar({
    this.titleColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.title,
    this.actions,
    this.automaticallyImplyLeading = false,
  });

  final Color titleColor;
  final Color backgroundColor;
  final String title;
  final List<Widget> actions;
  final bool automaticallyImplyLeading;

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
    );
  }
}