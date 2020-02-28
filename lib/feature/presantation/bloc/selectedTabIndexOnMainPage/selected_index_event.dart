import 'package:meta/meta.dart';

@immutable
abstract class SelectedIndexEvent {}

class UpdateIndexEvent extends SelectedIndexEvent {
  final index;

  UpdateIndexEvent({@required this.index});
}
