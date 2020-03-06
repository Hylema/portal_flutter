import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/mixins/blocs_dispatches_events.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/blocsResponses/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class EasyRefreshWidget extends StatefulWidget {
  final Widget child;
  final bool enableControlRefresh;
  final bool enableControlLoad;

  EasyRefreshWidget({
    @required this.child,
    @required this.enableControlRefresh,
    @required this.enableControlLoad,
  }){
    assert(child != null);
  }

  @override
  State<StatefulWidget> createState() => EasyRefreshWidgetState();
}

class EasyRefreshWidgetState extends State<EasyRefreshWidget> {

  EasyRefreshController _controller;

  @override
  void initState() {
    super.initState();

    _controller = EasyRefreshController();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return EasyRefresh(
      enableControlFinishRefresh: false,
      enableControlFinishLoad: false,
      controller: _controller,
      header: ClassicalHeader(
        showInfo: false,
        float: false,
      ),
      footer: ClassicalFooter(
          showInfo: false,
        float: false,
      ),
      onRefresh: () async {
        await Future.delayed(Duration(seconds: 2), () {});
      },
      onLoad: () async {
        await Future.delayed(Duration(seconds: 2), () {});
      },
      child: widget.child,
    );
  }
}


class EasyRefreshLineWidget extends StatefulWidget {
  final Widget child;
  EasyRefreshLineWidget({@required this.child}){
    assert(child != null);
  }

  @override
  State<StatefulWidget> createState() => EasyRefreshLineWidgetState();
}

class EasyRefreshLineWidgetState extends State<EasyRefreshLineWidget> {

  double refresh = 0;
  double oldState = 0;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
        child: Stack(
          children: <Widget>[
            widget.child,
            SizedBox(
                height: 4,
                child: !loading ? LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      refresh < 1
                          ? Color.fromRGBO(238, 0, 38, 0.4)
                          : Color.fromRGBO(238, 0, 38, 1)
                  ),
                  value: refresh,
                  backgroundColor: Colors.white,
                ) : LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromRGBO(238, 0, 38, 1)
                  ),
                  backgroundColor: Colors.white,
                )
            ),
          ],
        ),
        onNotification: (notification){
          if(notification is ScrollStartNotification) {

          }
          else if(notification is ScrollEndNotification){
            setState(() {
              if(refresh > 1) loading = true;
              refresh = 0;
            });

            Future.delayed(Duration(seconds: 5)).then((value){
              setState(() {
                loading = false;
              });
            });
          }
          else if(notification is ScrollUpdateNotification) {}
          else if(notification is OverscrollNotification) {
            if(!loading){
              setState(() {
                refresh += notification.dragDetails.delta.dy / 130;
              });
            }
          }
          return true;
        }
    );
  }
}





class SmartRefresherWidget extends StatefulWidget {
  final Widget child;
  final bool enableControlRefresh;
  final bool enableControlLoad;
  final String pageKey;

  SmartRefresherWidget({
    @required this.child,
    @required this.enableControlRefresh,
    @required this.enableControlLoad,
    @required this.pageKey,
  }){
    assert(child != null);
    assert(pageKey != null);
  }

  @override
  State<StatefulWidget> createState() => SmartRefresherWidgetState();
}

class SmartRefresherWidgetState extends State<SmartRefresherWidget> with Dispatch{

  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController();
  }

  @override
  void dispose() {
    super.dispose();
    _refreshController.dispose();
  }

  _refreshDispatches(){
    Map _refreshDispatches = {
      ///Main Page
      MAIN_PAGE: dispatchGetMainParamsFromJson,

      ///News Page
      NEWS_PAGE: dispatchGetNewsDataFromNetwork,
      NEWS_PAGE_SHIMMER: dispatchGetNewsDataFromNetwork,

      ///Profile Page
      PROFILE_PAGE: dispatchGetProfileDataFromNetwork,
      PROFILE_PAGE_SHIMMER: dispatchGetProfileDataFromNetwork,

      ///Birthday Page
      BIRTHDAY_PAGE: dispatchGetBirthdayFromNetwork,
      BIRTHDAY_PAGE_SHIMMER: dispatchGetBirthdayFromNetwork,

      ///Polls Page
      POLLS_PAGE: dispatchGetMainParamsFromJson,

      ///Video Page
      VIDEO_PAGE: dispatchGetVideosFromNetwork,
    };

    return _refreshDispatches[widget.pageKey]();
  }

  _loadDispatches(){
    Map _refreshDispatches = {
      ///News Page
      NEWS_PAGE: dispatchLoadMoreNewsDataFromNetwork,

      ///Video Page
      VIDEO_PAGE: dispatchLoadMoreVideosFromNetwork,

      ///Birthday Page
      BIRTHDAY_PAGE: dispatchLoadMoreBirthdayFromNetwork,
    };

    return _refreshDispatches[widget.pageKey]();
  }

  @override
  Widget build(BuildContext context) {

    return BlocListener<ResponsesBloc, ResponsesState>(
      listener: (context, ResponsesState state) {
        if(state is ResponseSuccessState) {
          _refreshController.refreshCompleted();
          _refreshController.loadComplete();

          var _successState = state.state;
          if(_successState is LoadedBirthdayState){
            if(_successState.model.birthdays.length == 0){
              _refreshController.loadNoData();
            }
          }
        }
        if(state is ResponseErrorState) {
          _refreshController.refreshFailed();
          _refreshController.loadFailed();
        }
      },
      child: SmartRefresher(
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
          noDataText: 'Дней рождений на сегодня больше нет',
          loadingIcon: CircularProgressIndicator(
            strokeWidth: 2.0,
            valueColor: AlwaysStoppedAnimation(
              Color.fromRGBO(238, 0, 38, 1),
            ),
          ),
        ),
        controller: _refreshController,
        child: widget.child,
        onRefresh: () => _refreshDispatches(),
        onLoading: () => _loadDispatches(),
      )
    );
  }
}
