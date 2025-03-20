import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/characters/domain/entities/characters_entity.dart';
import '../../features/characters/presentation/cubit/characters_cubit.dart';
import '../../features/characters/presentation/pages/character_datail_page.dart';
import '../../features/characters/presentation/pages/characters_page.dart';
import '../../features/home/page/home_page.dart';
import '../../injection_container.dart';
import 'routes.dart';

class AppRouter {
  Route generateRoutes(RouteSettings settings) {
    final charactersCubit = sl<CharactersCubit>();

    switch (settings.name) {
      case Routes.characters:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: charactersCubit..getCharacter(),
            child: const CharactersPage(),
          ),
        );
      case Routes.details:
        final character = settings.arguments as CharactersEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: charactersCubit,
            child: CharacterDetailPage(character: character),
          ),
        );
      case Routes.homePage:
      default:
        return MaterialPageRoute(
          builder: (context) => const HomePage(),
        );
    }
  }
}
