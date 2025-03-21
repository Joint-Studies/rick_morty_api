import 'package:flutter/material.dart';
import 'package:rick_morty_api/core/utils/app_strings.dart';
import '../../../../core/utils/theme_extensions_ui.dart';
import '../../domain/entities/characters_entity.dart';
import 'package:intl/intl.dart';

class CharacterDetailPage extends StatelessWidget {
  final CharactersEntity character;

  const CharacterDetailPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${character.name}',
          style: context.titleStyle,
        ),
        centerTitle: true,
        backgroundColor: Colors.greenAccent.shade700,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          Hero(
            tag: 'character_${character.id}',
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                15,
              ),
              child: Image.network(
                '${character.image}',
                height: 300,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '${AppStrings.name} ${character.name}',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildInfoRow(AppStrings.status, '${character.status}'),
          _buildInfoRow(AppStrings.specie, '${character.species}'),
          _buildInfoRow(AppStrings.origin, '${character.origin?.name}'),
          _buildInfoRow(AppStrings.localization, '${character.location?.name}'),
          _buildInfoRow(AppStrings.created, formatDate('${character.created}')),
          const SizedBox(height: 20),
        ],
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
          SizedBox(
            width: 5,
          ),
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
