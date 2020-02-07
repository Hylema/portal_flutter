import 'package:meta/meta.dart';

@immutable
abstract class ProfileEvent {}

class GetProfileFromCacheBlocEvent extends ProfileEvent {}
class GetProfileFromNetworkBlocEvent extends ProfileEvent {}
