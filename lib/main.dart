import 'package:flutter/material.dart';
import 'package:rick_morty_api/core/routes/router.dart';
import 'package:rick_morty_api/core/routes/routes.dart';
import 'package:rick_morty_api/features/home/home_page.dart';
import 'injection_container.dart' as sl;

void main() async {
  await sl.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _router = AppRouter();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: _router.generateRoutes,
      initialRoute: Routes.homePage,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
