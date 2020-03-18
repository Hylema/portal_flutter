import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class GetProfileFromCacheEvent extends ProfileEvent {}
class GetProfileFromNetworkEvent extends ProfileEvent {}
