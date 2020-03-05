import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/wave_animation.dart';
import 'package:flutter_architecture_project/core/mixins/blocs_dispatches_events.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_state.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/roundedLoadingButton/custom_rounded_loading_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

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
          height: 140,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 80,
          speed: 1.0,
        )),
        onBottom(AnimatedWave(
          height: 180,
          speed: 1.0,
        )),
        Positioned.fill(child: BuildBody()),
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

class BuildBody extends StatefulWidget {
  const BuildBody({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BuildBodyState();
}

class BuildBodyState extends State with TickerProviderStateMixin, Dispatch{
  AnimationController _rippleController;
  AnimationController _scaleController;

  CustomRoundedLoadingButtonController _btnController;

  Animation<double> _scaleAnimation;
  Animation<double> _rippleAnimation;

  bool _moveNextPage = false;
  bool _buttonPulse = false;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AppPage()));
      }
    });
    _scaleAnimation = Tween<double>(
        begin: 1.0,
        end: 30.0
    ).animate(_scaleController);


    _rippleController = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2)
    );
    _rippleAnimation = Tween<double>(
        begin: 80.0,
        end: 90.0
    ).animate(_rippleController)..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _rippleController.reverse();
      } else if(status == AnimationStatus.dismissed) {
        _rippleController.forward();
      }
    });

    _btnController = new CustomRoundedLoadingButtonController();
  }

  @override
  void dispose() {
    super.dispose();

  }

  Future _auth({@required context}) async {
    _btnController.needAuth();
    _rippleController.forward();

    setState(() {
      _buttonPulse = true;
    });

    await Future.delayed(Duration(milliseconds: 1400), () {});
    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AuthPage()));
  }

  Future _finish() async {
    _btnController.success();

    await Future.delayed(Duration(milliseconds: 1000), () {});

    setState(() {
      _moveNextPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_moveNextPage) _scaleController.forward();

    return BlocListener<AppBloc, AppState>(
      listener: (BuildContext context, AppState state) async {
        if(state is NeedAuth) await _auth(context: context);
        else if (state is Finish) await _finish();
      },
      child: Scaffold(
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
                    animation: _rippleAnimation,
                    builder: (context, child) => Container(
                      width: _buttonPulse ? _rippleAnimation.value : MediaQuery.of(context).size.width,
                      height: _rippleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _buttonPulse ? Color.fromRGBO(238, 0, 38, 1).withOpacity(.4) : Colors.white.withOpacity(0),
                        ),
                        child: AnimatedBuilder(
                          animation: _scaleAnimation,
                          builder: (context, child) => Transform.scale(
                            scale: _scaleAnimation.value,
                            child: _moveNextPage == false ? CustomRoundedLoadingButton(
                              child: Text('Начать', style: TextStyle(color: Colors.white)),
                              controller: _btnController,
                              onPressed: () {
                                dispatchGetProfileDataFromNetwork();
                                dispatchGetNewsDataFromNetwork();
                                dispatchGetMainParamsFromJson();
                                dispatchGetVideosFromNetwork();
                                dispatchGetBirthdayFromNetwork();
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
                    ),
                  ),
              ),
            ],
          )
      ),
    );
  }
}



