//import 'package:data_connection_checker/data_connection_checker.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:flutter_easyrefresh/easy_refresh.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';
//
//class EasyRefreshWidget extends StatefulWidget {
//  final Widget child;
//  final bool enableControlRefresh;
//  final bool enableControlLoad;
//
//  EasyRefreshWidget({
//    @required this.child,
//    @required this.enableControlRefresh,
//    @required this.enableControlLoad,
//  }){
//    assert(child != null);
//  }
//
//  @override
//  State<StatefulWidget> createState() => EasyRefreshWidgetState();
//}
//
//class EasyRefreshWidgetState extends State<EasyRefreshWidget> {
//
//  EasyRefreshController _controller;
//
//  @override
//  void initState() {
//    super.initState();
//
//    _controller = EasyRefreshController();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//
//    _controller.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return EasyRefresh(
//      enableControlFinishRefresh: false,
//      enableControlFinishLoad: false,
//      controller: _controller,
//      header: ClassicalHeader(
//        showInfo: false,
//        float: false,
//      ),
//      footer: ClassicalFooter(
//          showInfo: false,
//        float: false,
//      ),
//      onRefresh: () async {
//        await Future.delayed(Duration(seconds: 2), () {});
//      },
//      onLoad: () async {
//        await Future.delayed(Duration(seconds: 2), () {});
//      },
//      child: widget.child,
//    );
//  }
//}
//
//
//class EasyRefreshLineWidget extends StatefulWidget {
//  final Widget child;
//  EasyRefreshLineWidget({@required this.child}){
//    assert(child != null);
//  }
//
//  @override
//  State<StatefulWidget> createState() => EasyRefreshLineWidgetState();
//}
//
//class EasyRefreshLineWidgetState extends State<EasyRefreshLineWidget> {
//
//  double refresh = 0;
//  double oldState = 0;
//
//  bool loading = false;
//
//  @override
//  void initState() {
//    super.initState();
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return NotificationListener(
//        child: Stack(
//          children: <Widget>[
//            widget.child,
//            SizedBox(
//                height: 4,
//                child: !loading ? LinearProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(
//                      refresh < 1
//                          ? Color.fromRGBO(238, 0, 38, 0.4)
//                          : Color.fromRGBO(238, 0, 38, 1)
//                  ),
//                  value: refresh,
//                  backgroundColor: Colors.white,
//                ) : LinearProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(
//                      Color.fromRGBO(238, 0, 38, 1)
//                  ),
//                  backgroundColor: Colors.white,
//                )
//            ),
//          ],
//        ),
//        onNotification: (notification){
//          if(notification is ScrollStartNotification) {
//
//          }
//          else if(notification is ScrollEndNotification){
//            setState(() {
//              if(refresh > 1) loading = true;
//              refresh = 0;
//            });
//
//            Future.delayed(Duration(seconds: 5)).then((value){
//              setState(() {
//                loading = false;
//              });
//            });
//          }
//          else if(notification is ScrollUpdateNotification) {}
//          else if(notification is OverscrollNotification) {
//            if(!loading){
//              setState(() {
//                refresh += notification.dragDetails.delta.dy / 130;
//              });
//            }
//          }
//          return true;
//        }
//    );
//  }
//}
//
//
//class SmartRefresherWidget extends StatefulWidget {
//  final Widget child;
//  final bool enableControlRefresh;
//  final bool enableControlLoad;
//  final Function onRefresh;
//  final Function onLoading;
//
//  SmartRefresherWidget({
//    @required this.child,
//    @required this.enableControlRefresh,
//    @required this.enableControlLoad,
//    this.onRefresh,
//    this.onLoading,
//  }){
//    assert(child != null);
//  }
//
//  @override
//  State<StatefulWidget> createState() => SmartRefresherWidgetState();
//}
//
//String loadMessage;
//
//class SmartRefresherWidgetState extends State<SmartRefresherWidget> {
//
//  RefreshController _refreshController;
//
//  @override
//  void initState() {
//    super.initState();
//    _refreshController = new RefreshController();
//
//    DataConnectionChecker().onStatusChange.listen((status) {
//      switch (status) {
//        case DataConnectionStatus.connected:
//          _refreshController.resetNoData();
//          break;
//        case DataConnectionStatus.disconnected:
//          _refreshController.loadNoData();
//          print('Отключение от сети');
//          setState(() {
//            loadMessage = '''
//            Нет доступа к сети.
//            Ожидание подключения...
//            ''';
//          });
//          break;
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    super.dispose();
//    _refreshController.dispose();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//
//    return SmartRefresher(
//      enablePullUp: widget.enableControlLoad,
//      enablePullDown: widget.enableControlRefresh,
//      header: WaterDropMaterialHeader(
//        backgroundColor: Color.fromRGBO(238, 0, 38, 1),
//        color: Colors.white,
//        distance: 30,
//      ),
//      footer: ClassicFooter(
//        loadingText: 'Загрузка...',
//        canLoadingText: 'Загрузить ещё',
//        noDataText: loadMessage,
//        loadingIcon: CircularProgressIndicator(
//          strokeWidth: 2.0,
//          valueColor: AlwaysStoppedAnimation(
//            Color.fromRGBO(238, 0, 38, 1),
//          ),
//        ),
//      ),
//      controller: _refreshController,
//      child: widget.child,
//      onRefresh: widget.onRefresh,
//      onLoading: widget.onLoading,
//    );
//  }
//}
