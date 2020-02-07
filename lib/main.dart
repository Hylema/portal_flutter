import 'package:flutter/material.dart';
import 'package:flutter_architecture_project/feature/presantation/pages/app_page.dart';
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
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => AppPage(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
