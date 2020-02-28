import 'package:meta/meta.dart';

@immutable
abstract class SelectedIndexState {}

class LoadedSelectedIndexState extends SelectedIndexState {
  final index;

  LoadedSelectedIndexState({this.index = 0});
}
