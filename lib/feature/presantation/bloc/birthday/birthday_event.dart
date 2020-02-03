import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class BirthdayEvent extends Equatable{
  BirthdayEvent([List props = const <dynamic>[]]) : super(props);
}

class GetBirthdayEventBloc extends BirthdayEvent {
  final skip;
  final top;

  GetBirthdayEventBloc(this.skip, this.top) : super([skip, top]);
}