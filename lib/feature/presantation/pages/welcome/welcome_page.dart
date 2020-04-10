import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/animation/wave_animation.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/auth_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_event.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/pageLoading/bloc.dart';
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

    BlocSupervisor.delegate = SupervisorWelcomePage(
        snackBar: Scaffold.of(context).showSnackBar,
        blocAuth: BlocProvider.of<AuthBloc>(context),
        pageLoadingBloc: BlocProvider.of<PageLoadingBloc>(context),
        context: context
    );
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

  _loadingData(){
    _birthdayBloc.add(ResetFilterBirthdayEvent());
//    BlocProvider.of<ProfileBloc>(context).add(GetProfileFromNetworkEvent());
//    BlocProvider.of<NewsPortalBloc>(context).add(ResetFilterNewsEvent());
//    BlocProvider.of<VideoGalleryBloc>(context).add(Vide());
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

    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (BuildContext context, AuthState state) async {
            if(state is NeedAuthState) await _auth(context: context);
            else if (state is AuthCompletedState) await _loadingData();
          },
        ),
        BlocListener<PageLoadingBloc, PageLoadingState>(
          listener: (BuildContext context, PageLoadingState state) async {
            if(state is AllPageLoaded) await _finish();
          },
        )
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
                              onPressed: () {
                                _loadingData();
                              },
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

class SupervisorWelcomePage extends BlocDelegate {

  final Function snackBar;
  final AuthBloc blocAuth;
  final PageLoadingBloc pageLoadingBloc;
  final BuildContext context;

  SupervisorWelcomePage({
    @required this.snackBar,
    @required this.blocAuth,
    @required this.pageLoadingBloc,
    @required this.context
  });

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.nextState);

    if(transition.nextState is LoadedBirthdayState){
      pageLoadingBloc.add(SuccessLoading(state: LoadingBirthdayState));
    }
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) async {
    super.onError(bloc, error, stacktrace);
    if(error is AuthException) {
      Navigator.pushNamed(context, '/auth');
      //Navigator.pushReplacementNamed(context, '/auth');
      return;
    } else if(error is ServerException){
      Navigator.pushNamed(context, '/auth');
      return;
    } else if(error is NetworkException){
      pageLoadingBloc.add(AllPageLoadedEvent());
    }

    print(error);

    int seconds;
    String errorMessage = error.toString();

    if(error is ServerException) errorMessage = error.message;
    if(error is NetworkException) errorMessage = error.message;

    final int errorMessageLength = errorMessage.length;

    if(errorMessageLength > 20 && errorMessageLength < 40) seconds = 3;
    else if(errorMessageLength > 40 && errorMessageLength < 60) seconds = 4;
    else if(errorMessageLength > 69 && errorMessageLength < 80) seconds = 5;
    else if(errorMessageLength > 80 && errorMessageLength < 100) seconds = 6;
    else if(errorMessageLength > 100 && errorMessageLength < 120) seconds = 7;
    else if(errorMessageLength > 120 && errorMessageLength < 140) seconds = 8;
    else if(errorMessageLength > 140 && errorMessageLength < 160) seconds = 9;
    else seconds = 15;

    snackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: seconds),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {},
          ),
        )
    );
  }
}