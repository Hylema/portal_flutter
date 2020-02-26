import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Birthday extends Equatable {
  final birthdays;

  Birthday({
    @required this.birthdays,
  }) : super([birthdays]);
}