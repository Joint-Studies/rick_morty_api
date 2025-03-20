import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_api/features/locations/domain/entities/location_entity.dart';
import 'package:rick_morty_api/features/locations/presentation/pages/location_details_page.dart';
import '../../features/locations/presentation/cubit/locations_cubit.dart';
import '../../features/locations/presentation/pages/location_page.dart';

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
    final locationCubit = sl<LocationsCubit>();

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
      case Routes.location:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: locationCubit..getLocationResponse(),
            child: LocationPage(),
          ),
        );
      case Routes.locationDetails:
        final location = settings.arguments as LocationEntity;
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: locationCubit,
            child: LocationDetailsPage(
              location: location,
            ),
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
