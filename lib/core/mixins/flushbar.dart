import 'package:flushbar/flushbar.dart';

flushbar(context, message){
  return Flushbar(
      message:  message,
      duration:  Duration(seconds: 5),
      flushbarPosition: FlushbarPosition.TOP
  )..show(context);
}