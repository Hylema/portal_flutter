import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RefreshLoadedWidget {

  static Widget smartRefresh({
    @required Widget child,
    @required bool enableControlRefresh,
    @required bool enableControlLoad,
    Function onRefresh,
    Function onLoading,
    String noDataText
  }){
    RefreshController _refreshController = new RefreshController();
    return SmartRefresher(
      enablePullUp: enableControlLoad,
      enablePullDown: enableControlRefresh,
      header: WaterDropMaterialHeader(
        backgroundColor: Color.fromRGBO(238, 0, 38, 1),
        color: Colors.white,
        distance: 30,
      ),
      footer: ClassicFooter(
        loadingText: 'Загрузка...',
        canLoadingText: 'Загрузить ещё',
        noDataText: noDataText,
        loadingIcon: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(
            Color.fromRGBO(238, 0, 38, 1),
          ),
        ),
      ),
      controller: _refreshController,
      child: child,
      onRefresh: onRefresh,
      onLoading: onLoading,
    );
  }

  static Widget easyRefresh({
    @required Widget child,
    @required bool enableControlRefresh,
    @required bool enableControlLoad,
    Function onRefresh,
    Function onLoading,
    String noDataText
  }){
    EasyRefreshController _controller = new EasyRefreshController();

    return EasyRefresh(
      enableControlFinishRefresh: enableControlRefresh,
      enableControlFinishLoad: enableControlLoad,
      controller: _controller,
      header: ClassicalHeader(
        showInfo: false,
        float: false,
      ),
      footer: ClassicalFooter(
        showInfo: false,
        float: false,
      ),
      onRefresh: onRefresh,
      onLoad: onLoading,
      child: child,
    );
  }
}