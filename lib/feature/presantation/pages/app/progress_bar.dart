import 'package:flutter/material.dart';

class ProgressBar extends StatefulWidget {

  @override
  ProgressBarState createState() => ProgressBarState();
}

class ProgressBarState extends State<ProgressBar> with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  double beginAnim = 0.0;

  double endAnim = 0.8;

  @override
  void initState() {
    super.initState();



    controller = AnimationController(
        duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: beginAnim, end: endAnim).animate(controller);

    controller.forward();
  }



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





//class GetAllDataProgressBar extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: BlocProvider(
//          builder: (context) => sl<NewsPortalBloc>(),
//          child: ProgressBarNewsPortal()
//      ),
//    );
//  }
//}

//class ProgressBarNewsPortal extends StatefulWidget {
//
//  @override
//  ProgressBarNewsPortalState createState() => ProgressBarNewsPortalState();
//}
//
//class ProgressBarNewsPortalState extends State<ProgressBarNewsPortal> with SingleTickerProviderStateMixin{
//  AnimationController controller;
//  Animation animation;
//
//  double beginAnim = 0.0 ;
//  double endAnim = 0.8 ;
//
//  bool test = true;
//  @override
//  void initState() {
//    super.initState();
//
//    controller = AnimationController(
//        duration: const Duration(seconds: 1), vsync: this);
//    animation = Tween(begin: beginAnim, end: endAnim).animate(controller);
//
//    controller.forward();
//
//    dispatchFirstNewsPortal();
//  }
//
//  void dispatchFirstNewsPortal() {
//    BlocProvider.of<NewsPortalBloc>(context)
//        .dispatch(GetFirstNewsPortalBloc(0, 5));
//  }
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      child: BlocBuilder<NewsPortalBloc, NewsPortalState>(
//        builder: (context, state) {
//          if(state is Loading){
//            return Stack(
//              children: <Widget>[
//                Image.asset(
//                  "assets/images/metInvestBackground.png",
//                  height: MediaQuery.of(context).size.height,
//                  width: MediaQuery.of(context).size.width,
//                  fit: BoxFit.cover,
//                ),
//                Scaffold(
//                  backgroundColor: Colors.transparent,
//                  body: Stack(
//                    children: <Widget>[
//                      Align(
//                        alignment: Alignment(0, 0),
//                        child: Image.asset(
//                          'assets/images/metInvestIcon.png',
//                          width: 220,
//                        ),
//                      ),
//                      Align(
//                        alignment: Alignment(0, 0.8),
//                        child: SizedBox(
//                          height: 5,
//                          width: 300,
//                          child: LinearProgressIndicator(
//                            value: test
//                                ? animation.value
//                                : 1.0,
//                            backgroundColor: Colors.grey[300],
//                            valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(238, 0, 38, 1)),
//                          ),
//                        ),
//                      ),
//                    ],
//                  ),
//                )
//              ],
//            );
//          } else if(state is Loaded){
//            print('Страница загрузилась, теперь перенаправление');
//            test = false;
//            Navigator.push(context, FadeRoute(page: AppPage()));
//          } else {
//            return Center(
//              child: Text('ошибка'),
//            );
//          }
//        },
//      )
//    );
//  }
//}


//Navigator.push(context, FadeRoute(page: HomePage()