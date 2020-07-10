import 'package:flutter_architecture_project/feature/data/models/booking/meeting_type_model.dart';
import 'package:flutter_architecture_project/feature/data/params/params.dart';

class RemoveBookingParams extends Params{
  final int id;
  final String organization;

  RemoveBookingParams({
    this.id,
    this.organization,
  });

  @override
  List get props => [
    id, organization
  ];

  @override
  Map get urlProps => {
    'organization': organization,
  };
}