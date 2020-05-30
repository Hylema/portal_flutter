import 'package:meta/meta.dart';

@immutable
abstract class NavigationBarState {}

class InitialNavigationBarState extends NavigationBarState {
  final bool isVisible;
  InitialNavigationBarState({@required this.isVisible});
}
