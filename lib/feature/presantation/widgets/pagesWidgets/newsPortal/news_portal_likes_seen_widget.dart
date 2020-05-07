import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LikesSeenWidget extends StatelessWidget {

  final likesCount;
  LikesSeenWidget({@required this.likesCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                Icon(
                  Icons.remove_red_eye,
                  size: 16,
                  color: Colors.grey,
                ),
                Text(
                  ' 0',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10),
          ),
          Container(
            child: GestureDetector(
              child: Row(
                children: <Widget>[
                  Icon(
                    Icons.favorite_border,
                    size: 16,
                    color: Colors.grey,
                  ),
                  Text(
                    ' $likesCount',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              onTap: (){
                print('Запись понравилась');
              },
            ),
          ),
        ],
      ),
    );
  }
}