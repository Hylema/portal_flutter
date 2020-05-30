import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class GetProfileEvent extends ProfileEvent {}
class GetProfileFromCacheEvent extends ProfileEvent {}
