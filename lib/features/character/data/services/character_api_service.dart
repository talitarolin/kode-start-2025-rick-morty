
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:kode_start_2025_rick_morty/features/character/data/models/character_model.dart';

class CharacterApiService {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';

  Future<List<CharacterModel>> fetchCharacters({required int page}) async {
    final response = await http.get(Uri.parse('$_baseUrl/character/?page=$page'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load characters');
    }
  }

  Future<List<CharacterModel>> searchCharacters(String name) async {
    final response = await http.get(Uri.parse('$_baseUrl/character/?name=$name'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List results = data['results'];
      return results.map((json) => CharacterModel.fromJson(json)).toList();
    } else {
      return []; 
    }
  }
}