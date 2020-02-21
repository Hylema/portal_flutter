import 'package:flutter_architecture_project/core/animation/pageAnimation/page_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:page_transition/page_transition.dart';


class CustomRoundedLoadingButton extends StatefulWidget {
  final CustomRoundedLoadingButtonController controller;

  final VoidCallback onPressed;

  final Widget child;

  final Color color;

  final double height;

  CustomRoundedLoadingButton(
      {Key key,
        this.controller,
        this.onPressed,
        this.child,
        this.color = Colors.blue,
        this.height = 50});

  @override
  State<StatefulWidget> createState() => RoundedLoadingButtonState();
}

class RoundedLoadingButtonState extends State<CustomRoundedLoadingButton>
    with TickerProviderStateMixin {
  AnimationController _buttonController;
  AnimationController _checkButtonControler;

  Animation _squeezeAnimation;
  Animation _bounceAnimation;

  bool _isSuccessful = false;
  bool _isErrored = false;
  bool _isAuth = false;

  @override
  Widget build(BuildContext context) {
    var _check = Container(
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: widget.color,
          borderRadius:
          new BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? Icon(
          Icons.check,
          color: Colors.white,
        )
            : null);

    var _auth = GestureDetector(
      onTap: () {
        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: AuthPage()));
      },
      child: Container(
          alignment: FractionalOffset.center,
          decoration: new BoxDecoration(
            color: widget.color,
            borderRadius:
            new BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
          ),
          width: _bounceAnimation.value,
          height: _bounceAnimation.value,
          child: _bounceAnimation.value > 20
              ? Icon(
            Icons.person,
            color: Colors.white,
          )
              : null),
    );

    var _cross = Container(
        alignment: FractionalOffset.center,
        decoration: new BoxDecoration(
          color: Colors.red,
          borderRadius:
          new BorderRadius.all(Radius.circular(_bounceAnimation.value / 2)),
        ),
        width: _bounceAnimation.value,
        height: _bounceAnimation.value,
        child: _bounceAnimation.value > 20
            ? Icon(
          Icons.close,
          color: Colors.white,
        )
            : null);

    var _loader = SizedBox(
        height: widget.height - 25,
        width: widget.height - 25,
        child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            strokeWidth: 2));

    var _btn = ButtonTheme(
      shape:
      RoundedRectangleBorder(borderRadius: new BorderRadius.circular(35)),
      minWidth: _squeezeAnimation.value,
      height: widget.height,
      child: RaisedButton(
          child: _squeezeAnimation.value > 150 ? widget.child : _loader,
          color: widget.color,
          onPressed: () async {
            _start();
          }),
    );

    return Container(
        height: widget.height,
        child:
        Center(child: _isErrored ? _cross : _isSuccessful ? _check : _isAuth ? _auth : _btn));
  }

  @override
  void dispose() {

    _buttonController.dispose();
    _checkButtonControler.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    _buttonController = new AnimationController(
        duration: new Duration(milliseconds: 500), vsync: this);

    _checkButtonControler = new AnimationController(
        duration: new Duration(milliseconds: 1000), vsync: this);

    _bounceAnimation = Tween<double>(begin: 0, end: widget.height).animate(
        new CurvedAnimation(
            parent: _checkButtonControler, curve: Curves.elasticOut));
    _bounceAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation = Tween<double>(begin: 300, end: widget.height).animate(
        new CurvedAnimation(
            parent: _buttonController, curve: Curves.easeInOutCirc));
    _squeezeAnimation.addListener(() {
      setState(() {});
    });

    _squeezeAnimation.addStatusListener((state) {
      if (state == AnimationStatus.completed) {
        widget.onPressed();
      }
    });

    widget.controller?._addListeners(_start, _stop, _success, _error, _reset, _auth);
  }

  _auth() {
    _isSuccessful = false;
    _isErrored = false;
    _isAuth = true;
    _checkButtonControler.forward();
  }

  _start() {
    _buttonController.forward();
  }

  _stop() {
    _isSuccessful = false;
    _isErrored = false;
    _buttonController.reverse();
  }

  _success() {
    _isSuccessful = true;
    _isErrored = false;
    _isAuth = false;
    _checkButtonControler.forward();
  }

  _error() {
    _isErrored = true;
    _isAuth = false;
    _checkButtonControler.forward();
  }

  _reset() {
    _isSuccessful = false;
    _isErrored = false;
    _buttonController.reverse();
  }
}

class CustomRoundedLoadingButtonController {
  VoidCallback _startListener;
  VoidCallback _stopListener;
  VoidCallback _successListener;
  VoidCallback _errorListener;
  VoidCallback _resetListener;
  VoidCallback _authListener;

  _addListeners(
      VoidCallback startListener,
      VoidCallback stopListener,
      VoidCallback successListener,
      VoidCallback errorListener,
      VoidCallback resetListener,
      VoidCallback authListener
      ) {
    this._startListener = startListener;
    this._stopListener = stopListener;
    this._successListener = successListener;
    this._errorListener = errorListener;
    this._resetListener = resetListener;
    this._authListener = authListener;
  }

  start() {
    _startListener();
  }

  stop() {
    _stopListener();
  }

  success() {
    _successListener();
  }

  error() {
    _errorListener();
  }

  needAuth() {
    _authListener();
  }

  reset() {
    _resetListener();
  }
}