import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/birthday/birthday_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/newsPopularity/news_popularity_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/refreshIndicator/refresh_indicator_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/selectedTabIndexOnMainPage/selected_index_bloc.dart';
import 'package:flutter_architecture_project/feature/presantation/bloc/videoGallery/bloc.dart';
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
        BlocProvider<VideoGalleryBloc>(
          create: (BuildContext context) => di.sl<VideoGalleryBloc>(),
        ),
        BlocProvider<NewsPopularityBloc>(
          create: (BuildContext context) => di.sl<NewsPopularityBloc>(),
        ),
        BlocProvider<BirthdayBloc>(
          create: (BuildContext context) => di.sl<BirthdayBloc>(),
        ),
        BlocProvider<SelectedIndexBloc>(
          create: (BuildContext context) => di.sl<SelectedIndexBloc>(),
        ),
        BlocProvider<RefreshLineIndicatorBloc>(
          create: (BuildContext context) => di.sl<RefreshLineIndicatorBloc>(),
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


