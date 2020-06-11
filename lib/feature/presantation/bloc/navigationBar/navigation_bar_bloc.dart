import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class NavigationBarBloc extends Bloc<NavigationBarEvent, NavigationBarState> {
  @override
  NavigationBarState get initialState => InitialNavigationBarState(isVisible: true);

  @override
  Stream<NavigationBarState> mapEventToState(
    NavigationBarEvent event,
  ) async* {
    if(event is ShowNavigationBarEvent) yield InitialNavigationBarState(isVisible: true);
    else if(event is HideNavigationBarEvent) yield InitialNavigationBarState(isVisible: false);
  }
}
