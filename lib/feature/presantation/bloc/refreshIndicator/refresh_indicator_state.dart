import 'package:meta/meta.dart';

@immutable
abstract class RefreshLineIndicatorState {}

class InitialRefreshIndicatorState extends RefreshLineIndicatorState {}
class LoadingRefreshIndicatorState extends RefreshLineIndicatorState {}
class LoadedRefreshIndicatorState extends RefreshLineIndicatorState {
  final value;

  LoadedRefreshIndicatorState({this.value = 0.0});
}
