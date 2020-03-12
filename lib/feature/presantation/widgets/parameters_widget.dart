import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ParametersWidget extends StatefulWidget {
  final String title;
  final String textButton;
  final List<Widget> fields;
  final Function show;
  final Function throwData;

  ParametersWidget({
    @required this.title,
    @required this.textButton,
    @required this.fields,
    this.show,
    this.throwData
  });

  @override
  ParametersWidgetState createState() => ParametersWidgetState();
}

class ParametersWidgetState extends State<ParametersWidget> {
  bool disable = true;
  RoundedLoadingButtonController _btnController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _btnController = RoundedLoadingButtonController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          title: Text(widget.title, style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: [
            MaterialButton(
                onPressed: () {
                  widget.throwData();
                },
                child: Text('Сбросить', style: TextStyle(color: Colors.lightBlue, fontSize: 16),)
            ),
          ]
      ),
      body: CustomScrollView(
        slivers: <Widget>[
          SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(15),
                        child: Column(
                          children: widget.fields,
                        ),
                      ),
                      RoundedLoadingButton(
                        child: Text(widget.textButton, style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () {
                          widget.show();
//                          await Future.delayed(Duration(seconds: 3), () async {
//                            _btnController.success();
//                          });
//                          await Future.delayed(Duration(milliseconds: 1000), () {});
//                          Navigator.of(context).pop();
                        },
                        color: disable
                            ? Color.fromRGBO(238, 0, 38, 0.48)
                            : Color.fromRGBO(238, 0, 38, 1),
                      )
                    ],
                  ),
                  height: MediaQuery.of(context).size.height - MediaQuery.of(context).size.height/6,
                ),
              ])
          )
        ],
      ),
    );
  }
}