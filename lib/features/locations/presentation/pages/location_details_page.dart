import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rick_morty_api/core/utils/theme_extensions_ui.dart';
import 'package:rick_morty_api/features/characters/presentation/cubit/multiple_characters_cubit.dart';
import 'package:rick_morty_api/features/locations/domain/entities/location_entity.dart';

class LocationDetailsPage extends StatefulWidget {
  final LocationEntity location;

  const LocationDetailsPage({
    super.key,
    required this.location,
  });

  @override
  State<LocationDetailsPage> createState() => _LocationDetailsPageState();
}

class _LocationDetailsPageState extends State<LocationDetailsPage> {
  final dio = Dio();

  @override
  void initState() {
    super.initState();

    if (widget.location.residents != null && widget.location.residents!.isNotEmpty) {
      final ids = widget.location.residents!
          .map((url) {
            final id = url.split('/').last;
            return int.tryParse(id);
          })
          .where((id) => id != null)
          .cast<int>()
          .toList();

      context.read<MultipleCharactersCubit>().fetchMultipleCharacters(ids);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.location.name ?? 'Detalhes',
          style: context.titleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildInfoRow('Nome', '${widget.location.name}'),
            _buildInfoRow('Tipo', '${widget.location.type}'),
            _buildInfoRow('Dimensão', '${widget.location.dimension}'),
            _buildInfoRow('Criado em:', formatDate('${widget.location.created}')),
            SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'Residentes',
                style: context.titleStyle,
              ),
            ),
            BlocBuilder<MultipleCharactersCubit, MultipleCharactersState>(
              builder: (context, state) {
                if (state is MultipleCharactersLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is MultipleCharactersLoaded) {
                  if (state.responseEntity.charactersEntity != null) {
                    return Flexible(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: state.responseEntity.charactersEntity?.length,
                        itemBuilder: (context, position) {
                          final multiple = state.responseEntity.charactersEntity?[position];
                          return Column(
                            children: [
                              Flexible(
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 4,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(12),
                                    child: Image.network(
                                      multiple?.image ?? '',
                                      width: 150,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return multiple?.image == ''
                                            ? Image.asset('assets/images/default_image.png', width: 100, height: 100)
                                            : SizedBox.shrink();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                              Text(multiple?.name ?? '')
                            ],
                          );
                        },
                      ),
                    );
                  } else {
                    return Flexible(
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                state.responseEntity.characterEntity?.image ?? '',
                                width: 150,
                                height: 150,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return state.responseEntity.characterEntity?.image == ''
                                      ? Image.asset('assets/images/default_image.png', width: 100, height: 100)
                                      : SizedBox.shrink();
                                },
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Text(
                            state.responseEntity.characterEntity?.name ?? '',
                          )
                        ],
                      ),
                    );
                  }
                } else if (state is MultipleCharactersError) {
                  return Center(child: Text('Erro ao carregar personagens.'));
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            label,
            style: context.commonTextStyle,
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Tooltip(
              message: value,
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 18, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String formatDate(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    return DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
  }
}
