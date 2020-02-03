import 'package:flutter/material.dart';

class BlockMainPageWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Color background;
  BlockMainPageWidget({this.child, this.title, this.background = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: background,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22
                  ),
                ),
                GestureDetector(
                  child: Text(
                      'смотреть все',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18
                    ),
                  ),
                  onTap: () {
                    print('смотреть все');
                  },
                )
              ],
            ),
          ),
          Container(
            child: child
          ),
        ],
      ),
    );
  }
}