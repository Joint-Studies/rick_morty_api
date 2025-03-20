import 'package:flutter/material.dart';
import 'core/routes/router.dart';
import 'core/routes/routes.dart';
import 'core/utils/theme_data_ui.dart';
import 'features/home/page/home_page.dart';
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
      theme: ThemeDataUi.theme,
      home: const HomePage(),
    );
  }
}
