import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

class MainPageParameters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BuildMainPageParameters()
    );
  }
}

class BuildMainPageParameters extends StatefulWidget {

  @override
  BuildMainPageParametersState createState() => BuildMainPageParametersState();
}

class BuildMainPageParametersState extends State<BuildMainPageParameters> {

  var _data;

  List _listStatusTrue = [];
  List _listStatusFalse = [];

  final String path = 'assets/icons/';

  get _params => [..._listStatusTrue, ..._listStatusFalse];

  @override
  void initState() {

    dispatchGetMainParamsFromJson();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void removeItem(index){
    final item = _listStatusTrue.removeAt(index);
    item['status'] = false;
    _listStatusFalse.add(item);

    dispatchUpdateMainParams();
  }

  void addItem(index){
    final item = _listStatusFalse.removeAt(index);
    item['status'] = true;
    _listStatusTrue.add(item);

    print('_listStatusTrue ============== $_listStatusTrue');

    dispatchUpdateMainParams();
  }

  void dispatchGetMainParamsFromJson(){
    context.bloc<MainBloc>().add(GetParamsFromJsonForMainPageBlocEvent());
  }

  void dispatchSetMainParamsToJson(){
    context.bloc<MainBloc>().add(SetParamsToJsonForMainPageBlocEvent(_params));
  }

  void dispatchUpdateMainParams(){
    context.bloc<MainBloc>().add(UpdateMainParams(_params));
  }

  Widget getListTile(item, index, addOrRemove){
    return Container(
      padding: EdgeInsets.only(top: 10, bottom: 10, right: 20, left: 20),
      key: ValueKey(item['name']),
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
                    if(addOrRemove) removeItem(index);
                    else addItem(index);
                  },
                  child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          color: true == addOrRemove
                              ? Color.fromRGBO(255, 59, 48, 1)
                              : Color.fromRGBO(76, 217, 100, 1)
                      ),
                      width: 25,
                      height: 25,
                      child: true == addOrRemove
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
              child: true == addOrRemove ? Image.asset('${path}iconDrag.png') : Container()
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBloc, MainState>(
      builder: (context, state) {
        if(state is EmptyMainState){
          if(_data == null){
            return Center(child: Text('загрузка'),);
          }
          else return buildBody();
        } else if(state is LoadedMainParams){
          _data = state.model.params;

          print('Страница обновилась, новые данные === $_data');

          _listStatusTrue = [];
          _listStatusFalse = [];

          _data.asMap().forEach((index, item){
            if(item['status']){
              _listStatusTrue.add(item);
            } else {
              _listStatusFalse.add(item);
            }
          });

          return buildBody();
        } else {
          return Container();
        }
      },
    );
  }

//  updateParams(){
//    for(var i = 0; i < _listStatusTrue.length; i++){
//      _listStatusTrue[i]['status'] = true;
//    }
//    for(var i = 0; i < _listStatusFalse.length; i++){
//      _listStatusFalse[i]['status'] = false;
//    }
//
//    return [..._listStatusTrue, ..._listStatusFalse];
//  }

  Widget buildBody() {
    ScrollController _scrollController = PrimaryScrollController.of(context) ?? ScrollController();
    return Scaffold(
        appBar: AppBar(
            leading: GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Icon(Icons.close, color: Colors.black,),
            ),
            backgroundColor: Colors.white,
            title: Text('Управление виджетами', style: TextStyle(color: Colors.black),),
            centerTitle: true,
            actions: [
              MaterialButton(
                  onPressed: () {
                    dispatchSetMainParamsToJson();
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
                  children: _listStatusTrue
                      .asMap()
                      .map((index, item) => MapEntry(index, getListTile(item, index, true)))
                      .values
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    final item = _listStatusTrue.removeAt(oldIndex);
                    _listStatusTrue.insert(newIndex, item);

                    dispatchUpdateMainParams();
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
                  children: _listStatusFalse
                      .asMap()
                      .map((index, item) => MapEntry(index, getListTile(item, index, false)))
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