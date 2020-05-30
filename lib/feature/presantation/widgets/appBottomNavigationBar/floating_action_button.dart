import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'dart:math' as math;
class MainFloatingActionButtonWidget extends StatefulWidget {

  @override
  MainFloatingActionButtonWidgetState createState() => MainFloatingActionButtonWidgetState();
}

class MainFloatingActionButtonWidgetState extends State<MainFloatingActionButtonWidget> with TickerProviderStateMixin{

  bool isOpened = false;
  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Curve _curve = Curves.easeOut;

  @override
  initState() {
    _animationController =
    AnimationController(vsync: this, duration: Duration(milliseconds: 500))
      ..addListener(() {
        setState(() {});
      });
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.red,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  @override
  Widget build(BuildContext context) {
    //if(check) scaleController.forward();

    return GestureDetector(
      onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
      //onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
//      onVerticalDragUpdate: (v) {////        print('v 1=======================1 $v');
////        animate();
//        return DefaultBottomBarController.of(context).onDrag;
//      },
      onVerticalDragEnd: (DragEndDetails v) {
        print('primaryVelocity 2=======================2 ${v.primaryVelocity.ceil()}');
        //animate();
        return DefaultBottomBarController.of(context).onDragEnd(v);
      },
      //child: Icon(Icons.minimize, color: Colors.red, size: 50,)
      child: FloatingActionButton(
        backgroundColor: Color.fromRGBO(238, 0, 38, 1),
        onPressed: () {
          animate();
          DefaultBottomBarController.of(context).swap();
        },
        child: AnimatedIcon(
          icon: AnimatedIcons.list_view,
          progress: _animateIcon,
        ),
      ),
    );
  }
}



















//import 'package:flutter/material.dart';
//import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
//import 'dart:math' as math;
//class MainFloatingActionButtonWidget extends StatefulWidget {
//
//  @override
//  MainFloatingActionButtonWidgetState createState() => MainFloatingActionButtonWidgetState();
//}
//
//class MainFloatingActionButtonWidgetState extends State<MainFloatingActionButtonWidget> with TickerProviderStateMixin{
//
//  bool open = false;
//  bool check = true;
//
//  AnimationController scaleController;
//  Animation<double> scaleAnimation;
//
////  @override
////  void initState() {
////    super.initState();
////
////
////    scaleController = AnimationController(
////        vsync: this,
////        duration: Duration(milliseconds: 1200)
////    )..addStatusListener((status) {
////      if (status == AnimationStatus.completed) {
////        setState(() {
////          check = false;
////        });
////      }
////    });
////
////    scaleAnimation = Tween<double>(
////        begin: 30.0,
////        end: 1.0
////    ).animate(scaleController);
////  }
////
////  @override
////  void dispose(){
////    super.dispose();
////    scaleController.dispose();
////  }
//
//  @override
//  Widget build(BuildContext context) {
//    //if(check) scaleController.forward();
//
//    return GestureDetector(
//      onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
//      onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
//      //child: Icon(Icons.minimize, color: Colors.red, size: 50,)
//        child: Container(
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50.0),
//              color: Color.fromRGBO(238, 0, 38, 1)
//          ),
//          child: IconButton(
//            icon: Icon(Icons.keyboard_arrow_up),
//            iconSize: 38,
//            color: Colors.white,
//            onPressed: () {
//              return DefaultBottomBarController.of(context).swap();
//            },
//          ),
////          child: AnimatedBuilder(
////            animation: scaleAnimation,
////            builder: (context, child) => Transform.scale(
////              scale: scaleAnimation.value,
////              child: check == false ? IconButton(
////                icon: Icon(Icons.keyboard_arrow_up),
////                iconSize: 38,
////                color: Colors.white,
////                onPressed: () {
////                  return DefaultBottomBarController.of(context).swap();
////                },
////              ) : Container(
////                width: 100,
////                height: 100,
////                margin: EdgeInsets.all(10),
////                decoration: BoxDecoration(
////                  shape: BoxShape.circle,
////                  color: Color.fromRGBO(238, 0, 38, 1),
////                ),
////              ),
////            ),
////          ),
//        )
//    );
//  }
//}

