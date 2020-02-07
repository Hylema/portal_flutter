import 'package:flutter/material.dart';

class BlockMainPageWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final Color background;
  final Function updateIndex;
  final int index;

  BlockMainPageWidget({
    this.child,
    this.title,
    this.background = Colors.white,
    this.updateIndex,
    this.index
  });

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
                      fontSize: 20
                  ),
                ),
                GestureDetector(
                  child: Text(
                      'смотреть все',
                    style: TextStyle(
                      color: Color.fromRGBO(39, 131, 216, 1),
                      fontSize: 16
                    ),
                  ),
                  onTap: () {
                    print('Смеотреть все');
                    print(updateIndex);
                    updateIndex(index);
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