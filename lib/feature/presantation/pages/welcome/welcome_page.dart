import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';

class WelcomePage extends StatefulWidget {

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
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
                  child: MaterialButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AppPage(), fullscreenDialog: true));
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.only(
                        left: 75.0,
                        right: 75.0,
                        top: 16.0,
                        bottom: 16.0
                    ),
                    color: Color.fromRGBO(238, 0, 38, 1),
                    child: Text(
                      'Начать работу',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.0
                      ),
                    ),
                  ),
                ),
              ],
            )
        )
      ],
    );
  }
}