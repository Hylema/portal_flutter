import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class ParametersWidget extends StatelessWidget {
  final String title;
  final String textButton;
  final List<Widget> fields;
  final Function show;
  final Function throwData;
  final bool disable;

  ParametersWidget({
    @required this.title,
    @required this.textButton,
    @required this.fields,
    this.show,
    this.throwData,
    this.disable
  });

  @override
  Widget build(BuildContext context) {
    RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

    return Scaffold(
      appBar: AppBar(
          leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.close, color: Colors.black),
          ),
          backgroundColor: Colors.white,
          title: Text(title, style: TextStyle(color: Colors.black),),
          centerTitle: true,
          actions: [
            MaterialButton(
                onPressed: () => throwData(),
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
                          children: fields,
                        ),
                      ),
                      RoundedLoadingButton(
                        child: Text(textButton, style: TextStyle(color: Colors.white)),
                        controller: _btnController,
                        onPressed: () {
                          show();
                          Navigator.of(context).pop();
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
