import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/models/main/main_params_model.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

class MainPageParameters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if(state is LoadedMainParams){
          return MainPageParametersBody(model: state.model);
        } else {
          return Container();
        }
      },
    );
  }
}

class MainPageParametersBody extends StatelessWidget {

  final MainParamsModel model;
  MainPageParametersBody({@required this.model});

  @override
  Widget build(BuildContext context) {
    ScrollController _scrollController = PrimaryScrollController.of(context) ?? ScrollController();

    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Icon(Icons.close, color: Colors.black,),
            ),
            backgroundColor: Colors.white,
            title: Text('Управление виджетами', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              MaterialButton(
                  onPressed: () {
                    context.bloc<MainBloc>().add(SetPositionPagesEvent(model: model));
                    Navigator.pop(context);
                  },
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
                  scrollController: _scrollController,
                  needsLongPressDraggable: false,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: model.listStatusWithTrue
                      .asMap()
                      .map((index, item) => MapEntry(index, Container(key: ValueKey(item['name']), child: RawParameter(item: item, index: index, status: true, model: model))))
                      .values
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    model.changePositionItem(oldIndex: oldIndex, newIndex: newIndex);

                    context.bloc<MainBloc>().add(UpdateMainParams(model: model));
                  },
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
                  children: model.listStatusWithFalse
                      .asMap()
                      .map((index, item) => MapEntry(index, RawParameter(item: item, index: index, status: false, model: model)))
                      .values
                      .toList(),
                )
              ]),
            ),
          ],
        )
    );
  }
}

class RawParameter extends StatelessWidget {

  final String path = 'assets/icons/';

  final Map item;
  final int index;
  final bool status;
  final MainParamsModel model;

  RawParameter({
    @required this.item,
    @required this.index,
    @required this.status,
    @required this.model,
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
                  onTap: () {
                    if(status) model.removeItem(index: index);
                    else model.addItem(index: index);

                    context.bloc<MainBloc>().add(UpdateMainParams(model: model));
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: true == status
                              ? Color.fromRGBO(255, 59, 48, 1)
                              : Color.fromRGBO(76, 217, 100, 1)
                      ),
                      width: 25,
                      height: 25,
                      child: true == status
                          ? Icon(Icons.remove, color: Colors.white, size: 15,)
                          : Icon(Icons.add, color: Colors.white, size: 15,)
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10),
                child: Image.asset(item['icon'], width: 26, height: 26),
              ),
              Text(item['name']),
            ],
          ),
          Container(
              padding: EdgeInsets.all((5)),
              child: true == status ? Image.asset('${path}iconDrag.png') : Container()
          ),
        ],
      ),
    );
  }
}