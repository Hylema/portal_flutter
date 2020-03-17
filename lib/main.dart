import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/news_popularity_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';


import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;


class HandlerBlocDelegate extends BlocDelegate {

  final Function snackBar;
  final blocAuth;

  HandlerBlocDelegate({@required this.snackBar, @required this.blocAuth});

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if(transition.nextState is NeedAuthProfile){
      blocAuth.add(NeedAuthEvent());
    }
    print(transition.nextState);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('OnERROR ==================== $error');
    snackBar(SnackBar(content: Text(error)));
  }
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(BlocProvider<AuthBloc>(
      create: (BuildContext context) => di.sl<AuthBloc>(),
      child: Scaffold(
        body: App(),
      )),
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = HandlerBlocDelegate(
        snackBar: Scaffold.of(context).showSnackBar,
        blocAuth: BlocProvider.of<AuthBloc>(context)
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.welcome: (context) {
          return MultiBlocProvider(
              providers: [
                BlocProvider<ProfileBloc>(
                  create: (BuildContext context) => di.sl<ProfileBloc>(),
                ),
                BlocProvider<NewsPortalBloc>(
                  create: (BuildContext context) => di.sl<NewsPortalBloc>(),
                ),
                BlocProvider<VideoGalleryBloc>(
                  create: (BuildContext context) => di.sl<VideoGalleryBloc>(),
                ),
                BlocProvider<BirthdayBloc>(
                  create: (BuildContext context) => di.sl<BirthdayBloc>(),
                ),
              ],
              child: WelcomePage()
          );
        },
        Routes.app: (context) {
          return AppPage();
        },
      },
    );
  }
}


class Routes {
  static String welcome = '/';
  static String auth = '/auth';
  static String app = '/app';
}

//class MakeBlocsListener extends StatelessWidget {
//
//  int stateCount = 0;
//  int countPagesNeedAuthorization = 4;
//  bool authDoNotNeed = true;
//
//  void _processIsOver({
//    @required state
//  }){
//    ++stateCount;
//
//    print('MAIN STATE = $state');
//
//    switch(state){
//      case NeedAuthProfile: authDoNotNeed = false; break;
//      case NeedAuthNewsPortal: authDoNotNeed = false; break;
//      case NeedAuthBirthday: authDoNotNeed = false; break;
//      case NeedAuthVideoGalleryState: authDoNotNeed = false; break;
//    }
//
//
//    if(authDoNotNeed && stateCount == countPagesNeedAuthorization){
//      //dispatchAllPageLoaded();
//    }
//  }
//
//  void _showSnackBar({@required context, @required message}){
//    Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
////        theme: ThemeData(highlightColor: Color.fromRGBO(238, 0, 38, 0.1)),
//      home: WelcomePage(),
//      debugShowCheckedModeBanner: false,
//      routes: {
//        ArchSampleRoutes.home: (context) {
//          return MultiBlocProvider(
//            providers: [
//              BlocProvider<TabBloc>(
//                create: (context) => TabBloc(),
//              ),
//              BlocProvider<FilteredTodosBloc>(
//                create: (context) => FilteredTodosBloc(todosBloc: todosBloc),
//              ),
//              BlocProvider<StatsBloc>(
//                create: (context) => StatsBloc(todosBloc: todosBloc),
//              ),
//            ],
//            child: HomeScreen(),
//          );
//        },
//        ArchSampleRoutes.addTodo: (context) {
//          return AddEditScreen(
//            key: ArchSampleKeys.addTodoScreen,
//            onSave: (task, note) {
//              todosBloc.add(AddTodo(Todo(task, note: note)));
//            },
//            isEditing: false,
//          );
//        },
//      },
//    );
//  }
//}
