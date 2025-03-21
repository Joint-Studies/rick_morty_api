import 'package:flutter/material.dart';
import 'package:rick_morty_api/core/utils/app_strings.dart';
import '../../../core/routes/routes.dart';
import '../../../core/utils/theme_extensions_ui.dart';
import '../widgets/elevated_button_custom.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size.width,
              height: 200,
              alignment: Alignment.topCenter,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo1.png'),
                ),
              ),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text(
                  AppStrings.title,
                  style: context.titleStyle.copyWith(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 150,
          ),
          ElevatedButtonCustom(
            text: AppStrings.characters,
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.characters,
              );
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButtonCustom(
            onPressed: () {
              Navigator.of(context).pushNamed(
                Routes.location,
              );
            },
            text: AppStrings.location,
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButtonCustom(
            text: AppStrings.episodes,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
