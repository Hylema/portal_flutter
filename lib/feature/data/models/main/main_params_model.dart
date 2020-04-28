import 'package:meta/meta.dart';

class MainParamsModel {
  List params;

  List get listStatusWithTrue => _distribute(status: true);

  List get listStatusWithFalse => _distribute(status: false);

  MainParamsModel({
    @required this.params,
  });

  List _distribute({@required bool status}){
    List items = [];

    params.asMap().forEach((index, item){
      if(item['status'] == status){
        items.add(item);
      }
    });

    return items;
  }

  void removeItem({@required int index}){
    final item = listStatusWithTrue.removeAt(index);

    params.asMap().forEach((index, value){
      if(value['name'] == item['name']){
        params[index]['status'] = false;
      }
    });
  }

  void addItem({@required int index}){
    final item = listStatusWithFalse.removeAt(index);

    params.asMap().forEach((index, value){
      if(value['name'] == item['name']){
        params[index]['status'] = true;
      }
    });
  }

  void changePositionItem({@required int oldIndex, @required int newIndex}){
    List items = listStatusWithTrue;
    Map item = items.removeAt(oldIndex);
    items.insert(newIndex, item);

    params = [...items, ...listStatusWithFalse];
  }
}
