import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_project/feature/domain/params/birthday/birthday_params.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class FetchBirthdayEvent extends BirthdayEvent {}
class UpdateBirthdayEvent extends BirthdayEvent {}

class SetNewBirthdayFilter extends BirthdayEvent {
  final BirthdayParams params;

  SetNewBirthdayFilter({
    @required this.params,
  });
}

class ResetFilterBirthdayEvent extends BirthdayEvent{}

class GetBirthdayFromCache extends BirthdayEvent{}
