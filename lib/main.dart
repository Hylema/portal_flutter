import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/app/app_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/main/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/news/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/profile/bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/welcome/welcome_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProfileBloc>(
          create: (BuildContext context) => di.sl<ProfileBloc>(),
        ),
        BlocProvider<NewsPortalBloc>(
          create: (BuildContext context) => di.sl<NewsPortalBloc>(),
        ),
        BlocProvider<AppBloc>(
          create: (BuildContext context) => di.sl<AppBloc>(),
        ),
        BlocProvider<MainBloc>(
          create: (BuildContext context) => di.sl<MainBloc>(),
        ),
      ],
      child: MaterialApp(
//        theme: ThemeData(highlightColor: Color.fromRGBO(238, 0, 38, 0.1)),
        home: WelcomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
