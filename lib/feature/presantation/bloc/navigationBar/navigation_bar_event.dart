import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarEvent {}

class showNavigationBarEvent extends NavigationBarEvent {}
class hideNavigationBarEvent extends NavigationBarEvent {}