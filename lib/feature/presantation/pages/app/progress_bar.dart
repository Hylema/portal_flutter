import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:page_transition/page_transition.dart';

class ProgressBar extends StatefulWidget {

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: <Widget>[
            Image.asset(
              "assets/images/metInvestBackground.png",
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            Scaffold(
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
                    child: SizedBox(
                      height: 5,
                      width: 300,
                      child: LinearProgressIndicator(
//                          value: test
//                              ? animation.value
//                              : 1.0,
//                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(238, 0, 38, 1)),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
    );
  }
}