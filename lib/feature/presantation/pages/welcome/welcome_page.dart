import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:page_transition/page_transition.dart';

import 'dart:math';
import 'package:simple_animations/simple_animations.dart';


class WelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned.fill(child:  Image.asset(
          "assets/images/metInvestBackground.png",
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 120,
          speed: 0.9,
          offset: pi,
        )),
        onBottom(AnimatedWave(
          height: 220,
          speed: 1.2,
          offset: pi / 2,
        )),
        Positioned.fill(child: CenteredText()),
      ],
    );
  }

  onBottom(Widget child) => Positioned.fill(
    child: Align(
      alignment: Alignment.bottomCenter,
      child: child,
    ),
  );
}

class AnimatedWave extends StatelessWidget {
  final double height;
  final double speed;
  final double offset;

  AnimatedWave({this.height, this.speed, this.offset = 0.0});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Container(
        height: height,
        width: constraints.biggest.width,
        child: ControlledAnimation(
            playback: Playback.LOOP,
            duration: Duration(milliseconds: (5000 / speed).round()),
            tween: Tween(begin: 0.0, end: 2 * pi),
            builder: (context, value) {
              return CustomPaint(
                foregroundPainter: CurvePainter(value + offset),
              );
            }),
      );
    });
  }
}

class CurvePainter extends CustomPainter {
  final double value;

  CurvePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final white = Paint()..color = Colors.red[400].withAlpha(60);
    final path = Path();

    final y1 = sin(value);
    final y2 = sin(value + pi / 2);
    final y3 = sin(value + pi);

    final startPointY = size.height * (0.5 + 0.4 * y1);
    final controlPointY = size.height * (0.5 + 0.4 * y2);
    final endPointY = size.height * (0.5 + 0.4 * y3);

    path.moveTo(size.width * 0, startPointY);
    path.quadraticBezierTo(
        size.width * 0.5, controlPointY, size.width, endPointY);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawPath(path, white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

class CenteredText extends StatefulWidget {
  const CenteredText({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => CenteredTextState();
}

class CenteredTextState extends State with TickerProviderStateMixin{

  AnimationController scaleController;
  Animation<double> scaleAnimation;
  RoundedLoadingButtonController _btnController;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    scaleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 1)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AppPage()));
        //scaleController.reverse();
        check = false;
      }
    });

    _btnController = new RoundedLoadingButtonController();

    scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(scaleController);

  }

  bool check = false;

  @override
  Widget build(BuildContext context) {
    if(check) scaleController.forward();

    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment(0, 0),
              child: Image.asset(
                'assets/images/metInvestIcon.png',
                width: 220,
              ),
            ),
            Align(
                alignment: Alignment(0, 0.8),
                child: AnimatedBuilder(
                  animation: scaleAnimation,
                  builder: (context, child) => Transform.scale(
                    scale: scaleAnimation.value,
                    child: check == false ? RoundedLoadingButton(
                      child: Text('Начать', style: TextStyle(color: Colors.white)),
                      controller: _btnController,
                      onPressed: () async {
                        await Future.delayed(Duration(seconds: 3), () async {
                          _btnController.success();
                        });
                        await Future.delayed(Duration(milliseconds: 1000), () {});
                        setState(() {
                          check = true;
                        });
                      },
                      color: Color.fromRGBO(238, 0, 38, 1),
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
                )
            ),
          ],
        )
    );
  }
}

