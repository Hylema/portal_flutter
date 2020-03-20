import 'package:meta/meta.dart';

@immutable
abstract class PageLoadingState {}

class InitialPageLoadingState extends PageLoadingState {}
class AllPageLoaded extends PageLoadingState {}
