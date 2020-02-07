import 'package:flutter/material.dart';

class PollsMainPageCustomSwipeWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.only(left: 20, bottom: 20, top: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12.withOpacity(0.005),
                  blurRadius: 15.0,
                  spreadRadius: 0.2,
                  offset: Offset(
                    10, // horizontal, move right 10
                    10, // vertical, move down 10
                  ),
                ),
              ],
            ),
            child: Card(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      'Опрос о качестве нового портала',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Удобство использования',
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.only(left: 20),
            child: Card(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text('Опрос о качестве нового портала'),
                    subtitle: Text('Удобство использования'),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            padding: EdgeInsets.only(left: 20),
            child: Card(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text('Опрос о качестве нового портала'),
                    subtitle: Text('Удобство использования'),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Card(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text('Опрос о качестве нового портала'),
                    subtitle: Text('Удобство использования'),
                  )
                ],
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width / 1.3,
            child: Card(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                    title: Text('Опрос о качестве нового портала'),
                    subtitle: Text('Удобство использования'),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}