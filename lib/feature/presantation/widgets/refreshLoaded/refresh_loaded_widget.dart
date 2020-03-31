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
    return SmartRefresherWidget(
      child: child,
      enableControlLoad: enableControlLoad,
      enableControlRefresh: enableControlRefresh,
      onLoading: onLoading,
      onRefresh: onRefresh,
      noDataText: noDataText,
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

class SmartRefresherWidget extends StatefulWidget {
  final Widget child;
  final bool enableControlRefresh;
  final bool enableControlLoad;
  final Function onRefresh;
  final Function onLoading;
  final String noDataText;

  SmartRefresherWidget({
    @required Widget this.child,
    @required bool this.enableControlRefresh,
    @required bool this.enableControlLoad,
    Function this.onRefresh,
    Function this.onLoading,
    String this.noDataText
  });

  @override
  SmartRefresherWidgetState createState() => SmartRefresherWidgetState();
}

class SmartRefresherWidgetState extends State<SmartRefresherWidget> {

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();

    _refreshController = RefreshController();
  }

  @override
  void dispose() {
    super.dispose();

    _refreshController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _refreshController.loadComplete();
    _refreshController.refreshCompleted();
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
        noDataText: widget.noDataText,
        loadingIcon: CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation(
            Color.fromRGBO(238, 0, 38, 1),
          ),
        ),
      ),
      controller: _refreshController,
      child: widget.child,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
    );
  }
}