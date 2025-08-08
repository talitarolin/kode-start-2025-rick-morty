import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_counter_example/features/character/data/models/character_model.dart';

class CharacterApiService {
  final String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<CharacterModel>> fetchCharacters() async {
    final response = await http.get(Uri.parse('$_baseUrl/character'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }
}