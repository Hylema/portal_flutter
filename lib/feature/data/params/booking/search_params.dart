import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class SearchParams extends Params{
  final String value;

  SearchParams({
    this.value,
  });

  @override
  List get props => [
    value
  ];

  Map get bodyProps => {
    'value': value,
  };
}