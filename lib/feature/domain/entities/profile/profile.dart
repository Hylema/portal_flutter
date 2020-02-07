import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class Profile extends Equatable {
  final profile;

  Profile({
    @required this.profile,
  }) : super([profile]);
}