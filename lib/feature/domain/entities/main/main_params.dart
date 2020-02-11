import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class MainParams extends Equatable {
  final params;

  MainParams({
    @required this.params,
  }) : super([params]);
}