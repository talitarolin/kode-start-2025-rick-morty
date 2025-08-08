// lib/features/character/presentation/screens/character_list_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/models/character_model.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/providers/character_provider.dart';
import 'package:kode_start_2025_rick_morty/features/character/presentation/widgets/character_card.dart';
import 'package:kode_start_2025_rick_morty/routes/app_routes.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    Provider.of<CharacterProvider>(context, listen: false).fetchFirstPage();
    searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (searchController.text.isEmpty) {
      if (isSearching) {
        Provider.of<CharacterProvider>(context, listen: false).clearSearch();
        setState(() {
          isSearching = false;
        });
      }
    } else {
      Provider.of<CharacterProvider>(context, listen: false).searchCharacters(searchController.text);
    }
  }

  @override
  void dispose() {
    searchController.removeListener(_onSearchChanged);
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const customHeaderHeight = 55.92 + 75;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(customHeaderHeight),
        // Adicionando SafeArea para evitar a barra de notificação
        child: SafeArea(
          bottom: false, // O conteúdo do corpo já tem sua própria rolagem
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSearching
                ? _buildSearchHeader()
                : _buildDefaultHeader(),
          ),
        ),
      ),
      body: Consumer<CharacterProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.hasSearched && provider.characters.isEmpty) {
            return const Center(child: Text('Nenhum personagem encontrado. Experimente palavras-chave diferentes.'));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: provider.characters.length + (provider.hasMoreData && !provider.hasSearched ? 1 : 0),
            itemBuilder: (context, index) {
              if (index == provider.characters.length && !provider.hasSearched) {
                if (!provider.isLoading) {
                  provider.loadMoreCharacters();
                }
                return const Center(child: CircularProgressIndicator());
              }
              final character = provider.characters[index];
              return CharacterCard(
                character: character,
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.characterDetail, arguments: character);
                },
              );
            },
          );
        },
      ),
    );
  }

 Widget _buildDefaultHeader() {
    return Container(
      key: const ValueKey<bool>(false),
      width: double.infinity,
      height: 55.92 + 75,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          // Layout do cabeçalho como uma coluna
          Column(
            children: [
              // Retângulo do topo com ícones
              Container(
                width: double.infinity,
                height: 55.92,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(Icons.menu, size: 20.97, color: Colors.white),
                    Icon(Icons.person_outline, size: 31.46, color: Colors.white),
                  ],
                ),
              ),
              // Retângulo de baixo com o título
              Container(
                width: double.infinity,
                height: 75,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: const Center(
                  child: Text(
                    'RICK AND MORTY API',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Lato', // AQUI está a correção da fonte
                      fontWeight: FontWeight.w400, // AQUI está a correção do peso
                      fontSize: 14.5,
                      letterSpacing: 2.39, // 16.5% de 14.5px
                    ),
                  ),
                ),
              ),
            ],
          ),
          // Logo "Group 1192x.webp" sobrepondo os retângulos
          Positioned(
            top: 10,
            left: 123,
            child: Image.asset(
              'assets/images/Group_1192x.webp',
              width: 115,
              height: 76.98,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildSearchHeader() {
    return Container(
      key: const ValueKey<bool>(true),
      width: double.infinity,
      height: 55.92 + 75,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Stack(
        children: [
          Column(
            children: [
              Container(
                width: double.infinity,
                height: 55.92,
                padding: const EdgeInsets.symmetric(horizontal: 14.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.arrow_back_ios, size: 20.97, color: Colors.white),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, size: 31.45, color: Colors.white),
                      onPressed: () {
                        setState(() {
                          isSearching = false;
                          searchController.clear();
                          Provider.of<CharacterProvider>(context, listen: false).clearSearch();
                        });
                      },
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 75,
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: TextField(
                    controller: searchController,
                    style: const TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: const InputDecoration(
                      hintText: 'Buscar personagem...',
                      hintStyle: TextStyle(color: Colors.white70),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}