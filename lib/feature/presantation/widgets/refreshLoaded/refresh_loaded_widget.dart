import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/network/network_info.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

//class RefreshLoadedWidget extends StatefulWidget{
//
//  final Widget child;
//  final bool enableControlLoad;
//  final bool enableControlRefresh;
//  final Function onRefresh;
//  final Function onLoading;
//  final String noDataText;
//
//  RefreshLoadedWidget({
//    @required this.child,
//    @required this.enableControlRefresh,
//    @required this.enableControlLoad,
//    this.onRefresh,
//    this.onLoading,
//    this.noDataText
//  });
//
//  @override
//  RefreshLoadedWidgetState createState() => RefreshLoadedWidgetState();
//
////  Widget smartRefresh({
////    @required Widget child,
////    @required bool enableControlRefresh,
////    @required bool enableControlLoad,
////    Function onRefresh,
////    Function onLoading,
////    String noDataText
////  }){
////    return SmartRefresherWidget(
////      child: child,
////      enableControlLoad: enableControlLoad,
////      enableControlRefresh: enableControlRefresh,
////      onLoading: () async {
////      return onLoading();
////    },
////      onRefresh: onRefresh,
////      noDataText: noDataText,
////    );
////  }
////
////  Widget easyRefresh({
////    @required Widget child,
////    @required bool enableControlRefresh,
////    @required bool enableControlLoad,
////    Function onRefresh,
////    Function onLoading,
////    String noDataText
////  }){
////    EasyRefreshController _controller = new EasyRefreshController();
////
////    return EasyRefresh(
////      enableControlFinishRefresh: enableControlRefresh,
////      enableControlFinishLoad: enableControlLoad,
////      controller: _controller,
////      header: ClassicalHeader(
////        showInfo: false,
////        float: false,
////      ),
////      footer: ClassicalFooter(
////        showInfo: false,
////        float: false,
////      ),
////      onRefresh: onRefresh,
////      onLoad: () async {
////        if(!await networkInfo.isConnected) return onLoading();
////      },
////      child: child,
////    );
////  }
//}
//
//class RefreshLoadedWidgetState extends State<RefreshLoadedWidget>{
//
//  bool connection;
//  StreamSubscription subscription;
//
//  @override
//  void initState() {
//    // TODO: implement initState
//    super.initState();
//
//    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
//      if(result == ConnectivityResult.none){
//        setState(() {
//          connection = false;
//        });
//      } else {
//        setState(() {
//          connection = true;
//        });
//      }
//    });
//  }
//
//  @override
//  void dispose() {
//    // TODO: implement dispose
//    super.dispose();
//
//    subscription.cancel();
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    // TODO: implement build
//    return SmartRefresherWidget(
//      child: widget.child,
//      enableControlLoad: widget.enableControlLoad,
//      enableControlRefresh: widget.enableControlRefresh,
//      onLoading: () async {
//        return widget.onLoading();
//      },
//      onRefresh: widget.onRefresh,
//      noDataText: widget.noDataText,
//    );
//  }
//
//
//}
//


class SmartRefresherWidget extends StatefulWidget {
  final Widget child;
  final bool enableControlRefresh;
  final bool enableControlLoad;
  final bool hasReachedMax;
  final Function onRefresh;
  final Function onLoading;
  final String noDataText;

  SmartRefresherWidget({
    @required this.child,
    @required this.enableControlRefresh,
    @required this.enableControlLoad,
    this.hasReachedMax = true,
    this.onRefresh,
    this.onLoading,
    this.noDataText = 'Данных больше нету'
  });

  @override
  SmartRefresherWidgetState createState() => SmartRefresherWidgetState();
}

class SmartRefresherWidgetState extends State<SmartRefresherWidget> {

  RefreshController _refreshController;
  StreamSubscription _subscription;
  bool _connection = true;

  @override
  void initState() {
    super.initState();

    _refreshController = RefreshController();

    _subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('connection: $result');
      if(result == ConnectivityResult.none){
        setState(() {
          _connection = false;
        });
      } else {
        setState(() {
          _connection = true;
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();

    if(widget.hasReachedMax || !_connection){
      _refreshController.loadNoData();
    } else _refreshController.resetNoData();

    return SmartRefresher(
      enablePullUp: widget.enableControlLoad,
      enablePullDown: widget.enableControlRefresh,
      header: WaterDropMaterialHeader(
        backgroundColor: Color.fromRGBO(238, 0, 38, 1),
        color: Colors.white,
        distance: 30,
      ),
      footer: ClassicFooter(
        loadingText: 'Загрузка...',
        canLoadingText: 'Загрузить ещё',
        failedText: 'Ошибка при загрузке данных',
        noDataText: _connection ? widget.noDataText : 'Нет доступа к сети. Ожидание соединения...',
        loadingIcon: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(
            Color.fromRGBO(238, 0, 38, 1),
          ),
        ),
      ),
      controller: _refreshController,
      child: widget.child,
      onRefresh: () {
        if(_connection) widget.onRefresh();
        else _refreshController.refreshCompleted();
      },
      onLoading: () {
        if(_connection) widget.onLoading();
        else _refreshController.loadComplete();
        print('onLoading');
      },
    );
  }
}