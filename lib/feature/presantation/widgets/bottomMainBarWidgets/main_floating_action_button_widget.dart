import 'package:flutter/material.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'dart:math' as math;
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
        duration: Duration(milliseconds: 1200)
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
      //child: Icon(Icons.minimize, color: Colors.red, size: 50,)
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
        )
    );
  }
}



//class MyArc extends StatelessWidget {
//  final double diameter;
//
//  const MyArc({Key key, this.diameter = 200}) : super(key: key);
//
//  @override
//  Widget build(BuildContext context) {
//    return CustomPaint(
//      painter: MyPainter(),
//      size: Size(diameter, diameter),
//    );
//  }
//}
//
//// This is the Painter class
//class MyPainter extends CustomPainter {
//
//  @override
//  void paint(Canvas canvas, Size size) {
//    Paint paint = Paint()..color = Color.fromRGBO(238, 0, 38, 1);
//
//    canvas.drawArc(
//      Rect.fromCenter(
//        center: Offset(size.width / 2, size.height / 2),
//        height: size.height,
//        width: size.width,
//      ),
//
//      -math.pi,
//      -math.pi,
//      false,
//      paint,
//    );
//
//  }
//
//  @override
//  bool shouldRepaint(CustomPainter oldDelegate) => false;
//}