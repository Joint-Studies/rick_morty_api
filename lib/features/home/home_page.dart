import 'package:flutter/material.dart';
import 'package:rick_morty_api/core/routes/routes.dart';
import 'package:rick_morty_api/core/utils/theme_extensions_ui.dart';

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
                  'O guia definitivo',
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pushNamed(Routes.characters);
            },
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text('Personagens', style: context.titleStyle),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text('Lugares', style: context.titleStyle),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            onPressed: () {},
            child: Padding(
              padding: EdgeInsets.only(left: 40, right: 40),
              child: Text('Episodios', style: context.titleStyle),
            ),
          ),
        ],
      ),
    );
  }
}
