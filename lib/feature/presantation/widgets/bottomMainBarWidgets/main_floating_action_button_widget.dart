import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';

class MainFloatingActionButtonWidget extends StatefulWidget {

  @override
  MainFloatingActionButtonWidgetState createState() => MainFloatingActionButtonWidgetState();
}

class MainFloatingActionButtonWidgetState extends State<MainFloatingActionButtonWidget> with TickerProviderStateMixin{

  AnimationController _animationController;
  Animation _arrowAnimation;
  bool open = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _arrowAnimation = Tween(begin: 0.0, end: 3.1).animate(_animationController);
  }

  @override
  void dispose(){
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
      onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color.fromRGBO(238, 0, 38, 1)
        ),
        //color: Colors.red,
        child: AnimatedBuilder(
          animation: _animationController,
          builder: (context, child) => Transform.rotate(
              angle: _arrowAnimation.value,
              child: IconButton(
                //icon: Icon(Icons.expand_more),
                icon: Icon(Icons.keyboard_arrow_up),
                iconSize: 38,
                color: Colors.white,
                onPressed: () {
//                  _animationController.isCompleted
//                      ? _animationController.reverse()
//                      : _animationController.forward();

                  return DefaultBottomBarController.of(context).swap();
                },
              )
          ),
        ),
      ),
    );
  }
}