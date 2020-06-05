import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/core/constants/constants.dart';
import 'package:flutter_architecture_project/core/error/exceptions.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_state.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/navigationBar/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/current/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/polls/past/bloc.dart';
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
            BlocProvider<AuthBloc>(
                create: (BuildContext context) => di.sl<AuthBloc>()),
            BlocProvider<BirthdayBloc>(
              create: (BuildContext context) => di.sl<BirthdayBloc>()),
            BlocProvider<NewsPortalBloc>(
              create: (BuildContext context) => di.sl<NewsPortalBloc>()),
            BlocProvider<SelectedIndexBloc>(
              create: (BuildContext context) => di.sl<SelectedIndexBloc>()),
            BlocProvider<MainBloc>(
                create: (BuildContext context) => di.sl<MainBloc>()),
            BlocProvider<VideoGalleryBloc>(
                create: (BuildContext context) => di.sl<VideoGalleryBloc>()),
            BlocProvider<PastPollsBloc>(
                create: (BuildContext context) => di.sl<PastPollsBloc>()),
            BlocProvider<CurrentPollsBloc>(
                create: (BuildContext context) => di.sl<CurrentPollsBloc>()),
            BlocProvider<ProfileBloc>(
                create: (BuildContext context) => di.sl<ProfileBloc>()),
            BlocProvider<NavigationBarBloc>(
                create: (BuildContext context) => di.sl<NavigationBarBloc>()),
            BlocProvider<PhoneBookBloc>(
                create: (BuildContext context) => di.sl<PhoneBookBloc>()),
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
