import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
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
            BlocProvider<SelectedIndexBloc>(
              create: (BuildContext context) => di.sl<SelectedIndexBloc>()),
            BlocProvider<MainBloc>(
                create: (BuildContext context) => di.sl<MainBloc>()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            initialRoute: Routes.welcome,
            theme: ThemeData(highlightColor: Color.fromRGBO(238, 0, 38, 0.5).withOpacity(0.1)),
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