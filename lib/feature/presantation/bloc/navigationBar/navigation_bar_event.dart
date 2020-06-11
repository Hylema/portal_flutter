import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarEvent {}

class ShowNavigationBarEvent extends NavigationBarEvent {}
class HideNavigationBarEvent extends NavigationBarEvent {}