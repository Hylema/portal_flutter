import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class BookingRoomsParams extends Params{
  String organization;

  BookingRoomsParams({
    @required this.organization,
  });

  @override
  List get props => [
    organization
  ];

  @override
  Map get urlProps => {
    'organization': organization,
  };
}