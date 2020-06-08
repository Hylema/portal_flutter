import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/main/filter/main_page_filter_viewmodel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';
import 'package:stacked/stacked.dart';

class MainPageFilter extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainPageFilterViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () => model.goBack(),
              child: Icon(Icons.close, color: Colors.black,),
            ),
            backgroundColor: Colors.white,
            title: Text('Управление виджетами', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              MaterialButton(
                  onPressed: () => model.applyFilter(),
                  child: Text('Готово', style: TextStyle(color: Colors.lightBlue, fontSize: 16),)
              ),
            ]
        ),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'Отображаемые',
                      style: TextStyle(
                          color: Color.fromRGBO(119, 134, 147, 1)
                      ),
                    ),
                  ),
                ),
                ReorderableColumn(
                    scrollController: model.scrollController,
                    needsLongPressDraggable: false,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: model.listVisibleWidgets
                        .asMap().map((index, item) => MapEntry(index,
                        Container(
                            key: ValueKey(item['title']),
                            child: RawParameter(
                              item: item,
                              isVisible: true,
                              index: index,
                              changePositionFunc: model.changePositionWidget,
                            )
                        )
                    )
                    ).values.toList(),
                    onReorder: (oldIndex, newIndex) =>
                        model.reorderableItem(oldIndex: oldIndex, newIndex: newIndex)
                ),
                Container(
                  color: Colors.grey[200],
                  child: Padding(
                    padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    child: Text(
                      'Скрытые',
                      style: TextStyle(
                          color: Color.fromRGBO(119, 134, 147, 1)
                      ),
                    ),
                  ),
                ),
                ListView(
                  shrinkWrap: true,
                  children: model.listHideWidgets
                      .asMap().map((index, item) => MapEntry(index,
                      Container(
                          key: ValueKey(item['title']),
                          child: RawParameter(
                            item: item,
                            isVisible: false,
                            index: index,
                            changePositionFunc: model.changePositionWidget,
                          )
                      )
                  )
                  ).values.toList(),
                )
              ]),
            ),
          ],
        ),
      ),
      viewModelBuilder: () => MainPageFilterViewModel(
        navigation: Navigator.of(context),
      ),
    );
  }
}

class RawParameter extends StatelessWidget {

  final String path = 'assets/icons/';

  final Map item;
  final Function changePositionFunc;
  final bool isVisible;
  final int index;

  RawParameter({
    @required this.item,
    @required this.changePositionFunc,
    @required this.isVisible,
    @required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: GestureDetector(
                  onTap: () => changePositionFunc(index, isVisible),
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: isVisible
                              ? Color.fromRGBO(255, 59, 48, 1)
                              : Color.fromRGBO(76, 217, 100, 1)
                      ),
                      width: 25,
                      height: 25,
                      child: !isVisible
                          ? Icon(Icons.add, color: Colors.white, size: 15,)
                          : Icon(Icons.remove, color: Colors.white, size: 15,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Image.asset(item['icon'], width: 26, height: 26),
              ),
              Text(item['title']),
            ],
          ),
          Container(
              child: isVisible ? Image.asset('${path}iconDrag.png', height: BOTTOM_NAVIGATION_BAR_ICON_SIZE,) : Container()
          ),
        ],
      ),
    );
  }
}