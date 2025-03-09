import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_morty_api/features/characters/presentation/widgets/buttons_navigation_custom.dart';
import '../cubit/characters_cubit.dart';
import '../widgets/card_characters_custom.dart';
import 'package:lottie/lottie.dart';
// import 'package:flutter_mdi_icons/flutter_mdi_icons.dart';

class CharactersPage extends StatefulWidget {
  const CharactersPage({super.key});

  @override
  State<CharactersPage> createState() => _CharactersPageState();
}

class _CharactersPageState extends State<CharactersPage> {
  bool _showLoadingAnimation = true;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CharactersCubit, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoading || _showLoadingAnimation) {
            return Center(
              child: Lottie.asset(
                'assets/animation/rick.json',
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            );
          }
          if (state is CharactersLoaded) {
            return Stack(
              children: [
                GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: state.responseEntity.charactersEntity?.length,
                  itemBuilder: (context, position) {
                    final characters = state.responseEntity.charactersEntity?[position];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.amberAccent,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: CardCharactersCustom(
                            image: characters?.image ?? 'Personagem sem Imagem',
                            name: characters?.name ?? 'Personagem sem nome',
                            id: characters?.id ?? 0,
                          )),
                    );
                  },
                ),
                ButtonsNavigationCustom(
                  prev: 'Anterior',
                  next: 'Proxíma',
                  current: state.page,
                  page: state.responseEntity.infoEntity?.pages,
                  onPressedPrev: () {
                    context.read<CharactersCubit>().getPrevPage();
                  },
                  onPressedNext: () {
                    context.read<CharactersCubit>().getNextPage();
                  },
                )
              ],
            );
          } else if (state is CharactersError) {
            return Center(child: Text(state.msgError ?? ''));
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
    context.read<CharactersCubit>().getNextPage();
  }
}
