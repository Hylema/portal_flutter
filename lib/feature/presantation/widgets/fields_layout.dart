import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FieldsLayout extends StatelessWidget {

  final List<Widget> widgets;
  final Function onPressed;
  final String buttonTitle;
  FieldsLayout({@required this.widgets, @required this.onPressed, @required this.buttonTitle});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
              ...widgets,
              Container(
                child: Padding(
                    padding: EdgeInsets.all(20),
                    child: RaisedButton(
                        disabledColor: Color.fromRGBO(238, 0, 38, 0.48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: BorderSide(color: Colors.red),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(buttonTitle, style: TextStyle(color: Colors.white)),
                        ),
                        onPressed: onPressed,
                        color: Color.fromRGBO(238, 0, 38, 1)
                    )
                ),
                width: MediaQuery.of(context).size.width,
              )
            ])
        )
      ],
    );
  }
}