import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';


import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/pageLoading/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                create: (BuildContext context) => di.sl<AuthBloc>()),
            BlocProvider<PageLoadingBloc>(
                create: (BuildContext context) => di.sl<PageLoadingBloc>()),
            BlocProvider<BirthdayBloc>(
              create: (BuildContext context) => di.sl<BirthdayBloc>()),
            BlocProvider<NewsPortalBloc>(
              create: (BuildContext context) => di.sl<NewsPortalBloc>()),
          ],
          child: App()
      )
  );
}

class App extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.welcome,
      routes: {
        Routes.welcome: (context) {
          return Scaffold(
            body: CreateBlocSupervisor(
              page: WelcomePage(),
            ),
          );
        },
        Routes.app: (context) {
          return BlocProvider<SelectedIndexBloc>(
            create: (BuildContext context) => di.sl<SelectedIndexBloc>(),
            child: Scaffold(
              body: CreateBlocSupervisor(
                page: AppPage(),
              ),
            ),
          );
        },
        Routes.auth: (context) {
          return Scaffold(
            body: CreateBlocSupervisor(
              page: AuthPage(),
            ),
          );
        }
      },
    );
  }
}

class CreateBlocSupervisor extends StatelessWidget {
  final page;
  CreateBlocSupervisor({@required this.page});

  @override
  Widget build(BuildContext context) {
    BlocSupervisor.delegate = HandlerBlocDelegate(
        snackBar: Scaffold.of(context).showSnackBar,
        blocAuth: BlocProvider.of<AuthBloc>(context),
        pageLoading: BlocProvider.of<PageLoadingBloc>(context),
        context: context
    );

    return page;
  }
}

class HandlerBlocDelegate extends BlocDelegate {

  final Function snackBar;
  final AuthBloc blocAuth;
  final PageLoadingBloc pageLoading;
  final BuildContext context;

  HandlerBlocDelegate({
    @required this.snackBar,
    @required this.blocAuth,
    @required this.pageLoading,
    @required this.context
  });

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition.nextState);

    if(transition.nextState is LoadedBirthdayState){
      pageLoading.add(SuccessLoading(state: LoadingBirthdayState));
    }
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) async {
    super.onError(bloc, error, stacktrace);
    if(error is AuthException) {
      Navigator.pushNamed(context, '/auth');
      //Navigator.pushReplacementNamed(context, '/auth');
      return;
    } else if(error is ServerException){
//      blocAuth.add(NeedAuthEvent());
    print('Need auth ============================================= !');
    print('context =============================================$context !');
      Navigator.pushNamed(context, '/auth');
      return;
    }
    print('OnERROR ==================== $error');

    int seconds;
    String errorMessage = error.toString();

    if(error is ServerException) errorMessage = error.message;

    final int errorMessageLength = errorMessage.length;

    if(errorMessageLength > 20 && errorMessageLength < 40) seconds = 3;
    else if(errorMessageLength > 40 && errorMessageLength < 60) seconds = 4;
    else if(errorMessageLength > 69 && errorMessageLength < 80) seconds = 5;
    else if(errorMessageLength > 80 && errorMessageLength < 100) seconds = 6;
    else if(errorMessageLength > 100 && errorMessageLength < 120) seconds = 7;
    else if(errorMessageLength > 120 && errorMessageLength < 140) seconds = 8;
    else if(errorMessageLength > 140 && errorMessageLength < 160) seconds = 9;
    else seconds = 15;

    snackBar(
        SnackBar(
          content: Text(errorMessage),
          duration: Duration(seconds: seconds),
          action: SnackBarAction(
            label: 'Закрыть',
            onPressed: () {},
          ),
        )
    );
  }
}


