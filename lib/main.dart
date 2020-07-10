import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexNavigation/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/auth/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app/app_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/auth/auth_page.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/news/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/phoneBook/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/profile/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/videogallery/bloc/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(
      MultiBlocProvider(
          providers: [
            BlocProvider<SelectedIndexBloc>(
              create: (BuildContext context) => di.sl<SelectedIndexBloc>()),
            BlocProvider<NavigationBarBloc>(
                create: (BuildContext context) => di.sl<NavigationBarBloc>()),
          ],
          child: MaterialApp(
//            localizationsDelegates: [
//              GlobalMaterialLocalizations.delegate,
//              GlobalWidgetsLocalizations.delegate,
//              GlobalCupertinoLocalizations.delegate,
//            ],
//            supportedLocales: [
//              const Locale('ru', '')
//            ],
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.welcome,
            theme: ThemeData(
                highlightColor: Color.fromRGBO(238, 0, 38, 0.5).withOpacity(0.1),
                pageTransitionsTheme: PageTransitionsTheme(
                    builders: {
                      //TargetPlatform.android: OpenUpwardsPageTransitionsBuilder(),
                      TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    }
                )
            ),
            routes: {
              Routes.welcome: (context) {
                return Scaffold(
                  body: WelcomePage(),
                );
              },
              Routes.app: (context) {
                return Scaffold(
                  body: AppPage(),
                );
              },
              Routes.auth: (context) {
                return Scaffold(
                  body: AuthPage(),
                );
              }
            },
          )
      )
  );
}


