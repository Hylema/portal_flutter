import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/refreshIndicator/refresh_indicator_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/refreshIndicator/refresh_indicator_state.dart';


import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderAppMainBar extends StatefulWidget{

  HeaderAppMainBar({
    this.titleColor = Colors.black54,
    this.backgroundColor = Colors.white,
    this.titleText,
    this.action,
    this.automaticallyImplyLeading = false,
  }){
    assert(this.titleText != null);
  }
  final Color titleColor;
  final Color backgroundColor;
  final String titleText;
  final List<Widget> action;
  final bool automaticallyImplyLeading;

  @override
  HeaderAppMainBarState createState() => HeaderAppMainBarState();
}

class HeaderAppMainBarState extends State<HeaderAppMainBar> {

  double oldValue;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: widget.automaticallyImplyLeading,
      backgroundColor: widget.backgroundColor,
      elevation: 1.0,
      title: Text(
        widget.titleText,
        style: TextStyle(color: widget.titleColor),
      ),
      actions: widget.action,
      centerTitle: true,
    );
  }
}