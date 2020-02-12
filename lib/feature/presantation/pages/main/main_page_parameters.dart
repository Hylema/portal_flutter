import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/data/globalData/global_data.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/injection_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reorderables/reorderables.dart';

class MainPageParameters extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) => sl<MainBloc>(),
          child: BuildMainPageParameters()
      ),
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

  @override
  void initState() {
    super.initState();

    print('ИНИТ');


    _data = GlobalData.mainParams;

    _data.asMap().forEach((index, item){
      if(item['status']){
        _listStatusTrue.add(item);
      } else {
        _listStatusFalse.add(item);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void removeItem(index){
    final item = _listStatusTrue.removeAt(index);
    _listStatusFalse.add(item);
  }

  void addItem(index){
    final item = _listStatusFalse.removeAt(index);
    _listStatusTrue.add(item);
  }

  void dispatchGetMainParamsFromJson(){
    context.bloc<MainBloc>().add(GetParamsFromJsonForMainPageBlocEvent());
  }

  void dispatchSetMainParamsToJson(params){
    context.bloc<MainBloc>().add(SetParamsToJsonForMainPageBlocEvent(params));
  }

  Widget getListTile(item, index, addOrRemove){
    return ListTile(
        key: ValueKey(item['name']),
        title: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  if(addOrRemove) removeItem(index);
                  else addItem(index);

                  setState(() {});
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
        trailing: true == addOrRemove
            ? Padding(
          child: Image.asset('${path}iconDrag.png'),
          padding: EdgeInsets.all(15),
        ) : null
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainBloc, MainState>(
      builder: (context, state) {
        if(state is EmptyMainState){
          if(_data == null){
            return Center(child: Text('загрузка'),);
          }
          else return buildBody();
        } else if(state is LoadedMainState){
          _data = state.model.params;

          return buildBody();
        } else {
          return Container();
        }
      },
      listener: (context, state) {

      },
    );
  }

  void updateJson(){
    for(var i = 0; i < _listStatusTrue.length; i++){
      _listStatusTrue[i]['status'] = true;
    }
    for(var i = 0; i < _listStatusFalse.length; i++){
      _listStatusFalse[i]['status'] = false;
    }


    dispatchSetMainParamsToJson([..._listStatusTrue, ..._listStatusFalse]);
  }

  Widget buildBody() {
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
                    updateJson();
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
                  scrollController: ScrollController(),
                  needsLongPressDraggable: false,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _listStatusTrue
                      .asMap()
                      .map((index, item) => MapEntry(index, getListTile(item, index, true)))
                      .values
                      .toList(),
                  onReorder: (oldIndex, newIndex) {
                    setState(() {

                      final item = _listStatusTrue.removeAt(oldIndex);
                      _listStatusTrue.insert(newIndex, item);

                      updateJson();
                    });
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
