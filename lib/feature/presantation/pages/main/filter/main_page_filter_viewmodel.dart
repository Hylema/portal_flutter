import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:stacked/stacked.dart';

class MainPageFilterViewModel extends BaseViewModel {
  final MainBloc mainBloc;
  final NavigatorState navigation;

  MainPageFilterViewModel({@required this.mainBloc, @required this.navigation,}){
    MainState mainState = mainBloc.state;
    if(mainState is LoadedMainParams) {
      listVisibleWidgets = mainState.model.listVisibleWidgets;
      listHideWidgets = mainState.model.listHideWidgets;
    }
  }

  List listVisibleWidgets;
  List listHideWidgets;

  ScrollController scrollController = ScrollController();

  void applyFilter() {
    mainBloc.add(SavePositionWidgetsEvent(model: MainParamsModel(params: [
      ...listVisibleWidgets,
      ...listHideWidgets,
    ])));
    navigation.pop();
  }

  void goBack() {
    mainBloc.add(GetPositionWidgetsEvent());
    navigation.pop();
  }

  void _showItem({@required int index}){
    listHideWidgets[index]['visible'] = true;
    Map item = listHideWidgets.removeAt(index);
    listVisibleWidgets.add(item);
  }

  void _hideItem({@required int index}){
    listVisibleWidgets[index]['visible'] = false;
    Map item = listVisibleWidgets.removeAt(index);
    listHideWidgets.add(item);
  }

  void changePositionWidget(int index, bool isVisible) {
    if(isVisible) _hideItem(index: index);
    else _showItem(index: index);

    notifyListeners();
  }

  void reorderableItem({@required int oldIndex, @required int newIndex}){
    Map item = listVisibleWidgets.removeAt(oldIndex);
    listVisibleWidgets.insert(newIndex, item);

    notifyListeners();
  }
}