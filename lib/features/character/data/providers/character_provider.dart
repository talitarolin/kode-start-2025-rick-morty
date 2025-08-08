
import 'package:flutter/material.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/models/character_model.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/services/character_api_service.dart';

class CharacterProvider with ChangeNotifier {
  final CharacterApiService _apiService = CharacterApiService();
  List<CharacterModel> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  bool _hasSearched = false;
  bool _hasMoreData = true;

  List<CharacterModel> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasSearched => _hasSearched;
  bool get hasMoreData => _hasMoreData;

  Future<void> fetchFirstPage() async {
    _isLoading = true;
    _currentPage = 1;
    _hasMoreData = true;
    _hasSearched = false;
    _characters.clear();
    notifyListeners();

    try {
      final newCharacters = await _apiService.fetchCharacters(page: _currentPage);
      _characters = newCharacters;
      if (newCharacters.isEmpty) {
        _hasMoreData = false;
      }
    } catch (e) {
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadMoreCharacters() async {
    if (_isLoading || !_hasMoreData || _hasSearched) return;

    _currentPage++;
    _isLoading = true;
    notifyListeners();

    try {
      final newCharacters = await _apiService.fetchCharacters(page: _currentPage);
      _characters.addAll(newCharacters);
      if (newCharacters.isEmpty) {
        _hasMoreData = false;
      }
    } catch (e) {
      // Tratar o erro, se houver
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> searchCharacters(String name) async {
    _isLoading = true;
    _hasSearched = true;
    _characters.clear();
    notifyListeners();

    try {
      final searchResults = await _apiService.searchCharacters(name);
      _characters = searchResults;
      _hasMoreData = false;
    } catch (e) {

    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearSearch() {
    _hasSearched = false;
    _currentPage = 1;
    _hasMoreData = true;
    _characters.clear();
    fetchFirstPage(); 
  }
}