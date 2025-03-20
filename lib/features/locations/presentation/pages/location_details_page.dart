import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rick_morty_api/core/utils/theme_extensions_ui.dart';
import 'package:rick_morty_api/features/locations/domain/entities/location_entity.dart';

class LocationDetailsPage extends StatelessWidget {
  final LocationEntity location;
  final dio = Dio();

  LocationDetailsPage({
    super.key,
    required this.location,
  });

  Future<String> fetchCharacterImage(String residentUrl) async {
    try {
      final characterId = residentUrl.split('/').last;
      final response = await dio.get('https://rickandmortyapi.com/api/character/$characterId');

      if (response.statusCode == 200) {
        final data = response.data;
        return data['image'];
      } else {
        throw Exception('Erro ao carregar personagem');
      }
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          location.name ?? 'Detalhes',
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
            _buildInfoRow('Nome', '${location.name}'),
            _buildInfoRow('Tipo', '${location.type}'),
            _buildInfoRow('Dimensão', '${location.dimension}'),
            _buildInfoRow('Criado em:', formatDate('${location.created}')),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: location.residents?.length ?? 0,
                itemBuilder: (context, position) {
                  final residentUrl = location.residents?[position] ?? '';

                  return FutureBuilder<String>(
                    future: fetchCharacterImage(residentUrl),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError || snapshot.data == '') {
                        return const Icon(Icons.error);
                      } else {
                        return Card(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          elevation: 4,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              snapshot.data!,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                            ),
                          ),
                        );
                      }
                    },
                  );
                },
              ),
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
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis),
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
