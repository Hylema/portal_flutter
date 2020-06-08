import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/wave_animation.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/current/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/past/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/widgets/roundedLoadingButton/custom_rounded_loading_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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

class BuildBodyState extends State with TickerProviderStateMixin{
  AnimationController _rippleController;
  AnimationController _scaleController;

  CustomRoundedLoadingButtonController _btnController;

  Animation<double> _scaleAnimation;
  Animation<double> _rippleAnimation;

  bool _moveNextPage = false;
  bool _buttonPulse = false;

  BirthdayBloc _birthdayBloc;
  MainBloc _mainBloc;
  NewsPortalBloc _newsBloc;
  VideoGalleryBloc _videoGalleryBloc;
  PastPollsBloc _pastPollsBloc;
  CurrentPollsBloc _currentPollsBloc;
  ProfileBloc _profileBloc;
  AuthBloc _authBloc;
  PhoneBookBloc _phoneBookBloc;

  @override
  void initState() {
    super.initState();

    _scaleController = AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 500)
    )..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushNamed(context, '/app');
        //Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AppPage()));
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

    _btnController = CustomRoundedLoadingButtonController();

    _birthdayBloc = BlocProvider.of<BirthdayBloc>(context);
    _mainBloc = BlocProvider.of<MainBloc>(context);
    _newsBloc = BlocProvider.of<NewsPortalBloc>(context);
    _videoGalleryBloc = BlocProvider.of<VideoGalleryBloc>(context);
    _pastPollsBloc = BlocProvider.of<PastPollsBloc>(context);
    _currentPollsBloc = BlocProvider.of<CurrentPollsBloc>(context);
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _authBloc = BlocProvider.of<AuthBloc>(context);
    _phoneBookBloc = BlocProvider.of<PhoneBookBloc>(context);
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
    Navigator.pushNamed(context, '/auth');
  }

  _start(){
    _authBloc.add(CheckAuthEvent());
  }

  _loadData(){
    _birthdayBloc.add(UpdateBirthdayEvent());
    _mainBloc.add(GetPositionWidgetsEvent());
    _newsBloc.add(UpdateNewsEvent());
    _videoGalleryBloc.add(UpdateVideosEvent());
    _currentPollsBloc.add(FetchCurrentPolls());
    _pastPollsBloc.add(FetchPastPolls());
    _profileBloc.add(GetProfileEvent());
    _phoneBookBloc.add(FirstFetchPhoneBookEvent());
  }

  Future _finish() async {
    _btnController.success();
    _loadData();
    await Future.delayed(Duration(milliseconds: 1000), () {});

    setState(() {
      _moveNextPage = true;
    });
  }

  Future _finishWithError() async {
    _btnController.error();
    _loadData();
    await Future.delayed(Duration(milliseconds: 1000), () {});

    setState(() {
      _moveNextPage = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(_moveNextPage) _scaleController.forward();

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) async {
            if(state is NeedAuthState) await _auth(context: context);
            else if(state is AuthCompletedState) await _finish();
            else if(state is AuthFailedState) await _finishWithError();
          },
        ),
      ],
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
                              onPressed: () => _start(),
                              controller: _btnController,
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