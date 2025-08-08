import 'package:flutter/material.dart';
import 'package:flutter_counter_example/features/character/data/services/character_api_service.dart';
import 'package:flutter_counter_example/features/character/data/models/character_model.dart';
import 'package:flutter_counter_example/routes/app_routes.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  late final Future<List<CharacterModel>> _characters;
  final CharacterApiService _apiService = CharacterApiService();

  @override
  void initState() {
    super.initState();
    _characters = _apiService.fetchCharacters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personagens'),
      ),
      body: FutureBuilder<List<CharacterModel>>(
        future: _characters,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Erro: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final characters = snapshot.data!;
            return ListView.builder(
              itemCount: characters.length,
              itemBuilder: (context, index) {
                final character = characters[index];
                return ListTile(
                  title: Text(character.name),
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.characterDetail,
                      arguments: character,
                    );
                  },
                );
              },
            );
          } else {
            return const Center(child: Text('Nenhum personagem encontrado.'));
          }
        },
      ),
    );
  }
}