import 'package:meta/meta.dart';

class MainParamsModel {
  final List params;

  List get listVisibleWidgets => _distribute(value: true);

  List get listHideWidgets => _distribute(value: false);

  MainParamsModel({
    @required this.params,
  });

  List _distribute({@required bool value}){
    List items = [];

    params.asMap().forEach((index, item){
      if(item['visible'] == value){
        items.add(item);
      }
    });

    return items;
  }
}
