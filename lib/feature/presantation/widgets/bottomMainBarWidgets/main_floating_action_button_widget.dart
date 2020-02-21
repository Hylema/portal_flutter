import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';

class MainFloatingActionButtonWidget extends StatefulWidget {

  @override
  MainFloatingActionButtonWidgetState createState() => MainFloatingActionButtonWidgetState();
}

class MainFloatingActionButtonWidgetState extends State<MainFloatingActionButtonWidget> with TickerProviderStateMixin{

  bool open = false;
  bool check = true;

  AnimationController scaleController;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();


    scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 1500)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          check = false;
        });
      }
    });

    scaleAnimation = Tween<double>(
        begin: 30.0,
        end: 1.0
    ).animate(scaleController);
  }

  @override
  void dispose(){
    super.dispose();
    scaleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if(check) scaleController.forward();

    return GestureDetector(
      onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
      onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50.0),
            color: Color.fromRGBO(238, 0, 38, 1)
        ),
          child: AnimatedBuilder(
            animation: scaleAnimation,
            builder: (context, child) => Transform.scale(
              scale: scaleAnimation.value,
              child: check == false ? IconButton(
                icon: Icon(Icons.keyboard_arrow_up),
                iconSize: 38,
                color: Colors.white,
                onPressed: () {
                  return DefaultBottomBarController.of(context).swap();
                },
              ) : Container(
                width: 100,
                height: 100,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromRGBO(238, 0, 38, 1),
                ),
              ),
            ),
          ),
      ),
    );
  }
}