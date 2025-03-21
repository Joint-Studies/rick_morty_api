import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:rick_morty_api/core/routes/routes.dart';
import 'package:rick_morty_api/core/utils/app_strings.dart';
import 'package:rick_morty_api/core/utils/theme_extensions_ui.dart';
import 'package:rick_morty_api/features/characters/presentation/widgets/buttons_navigation_custom.dart';
import 'package:rick_morty_api/features/locations/presentation/cubit/locations_cubit.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({super.key});

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage> {
  bool _showLoadingAnimation = true;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppStrings.location,
          style: context.titleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: BlocBuilder<LocationsCubit, LocationsState>(
        builder: (context, state) {
          if (state is LocationsLoading || _showLoadingAnimation) {
            return Center(
              child: Lottie.asset(
                AppStrings.mortyAnimation,
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            );
          }
          if (state is LocationLoaded) {
            return Stack(
              children: [
                ListView.builder(
                    itemCount: state.responseEntity.locationEntity?.length,
                    itemBuilder: (context, position) {
                      final location = state.responseEntity.locationEntity?[position];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.amberAccent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(
                                15,
                              )),
                          child: ListTile(
                            title: Text('${location?.name}'),
                            subtitle: Text('${location?.type}'),
                            trailing: IconButton(
                              icon: Icon(
                                Icons.arrow_forward_ios,
                              ),
                              onPressed: () {
                                if (location != null) {
                                  Navigator.of(context).pushNamed(
                                    Routes.locationDetails,
                                    arguments: location,
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                      );
                    }),
                ButtonsNavigationCustom(
                  prev: AppStrings.prev,
                  next: AppStrings.next,
                  current: state.page,
                  page: state.responseEntity.infoEntity?.pages,
                  onPressedPrev: () {
                    context.read<LocationsCubit>().getPrevPage();
                  },
                  onPressedNext: () {
                    context.read<LocationsCubit>().getNextPage();
                  },
                )
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Future<void> _startLoadingAnimation() async {
    await Future.delayed(
      Duration(
        seconds: 4,
      ),
    );
    setState(() {
      _showLoadingAnimation = false;
    });
  }
}
