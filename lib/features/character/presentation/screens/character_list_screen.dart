import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
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

    const customHeaderHeight = 55.92 + 102;

    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(customHeaderHeight),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: isSearching ? _buildSearchHeader() : _buildDefaultHeader(),
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

            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              itemCount: provider.characters.length + (provider.hasMoreData && !provider.hasSearched ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == provider.characters.length && !provider.hasSearched) {
                  if (!provider.isLoading) {
                    provider.loadMoreCharacters();
                  }
                  return const Center(child: CircularProgressIndicator());
                }
                final character = provider.characters[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: SizedBox(
                    height: 160,
                    child: CharacterCard(
                      character: character,
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRoutes.characterDetail, arguments: character);
                      },
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildDefaultHeader() {
    return Container(
      key: const ValueKey<bool>(false),
      color: const Color(0xFF1C1B1F),
      height: 55.92 + 102,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 55.92,
              padding: const EdgeInsets.symmetric(horizontal: 13.98),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.menu,
                    size: 24, 
                    color: Colors.white,
                  ),
                  Icon(
                    Icons.person_outline,
                    size: 28, 
                    color: const Color(0xFFCAC4D0),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 35.0,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/Group_1192x.webp',
                    width: 115,
                    height: 76.98,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'RICK AND MORTY API',
                    style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16, 
                      fontWeight: FontWeight.w400,
                      letterSpacing: 2.5, 
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchHeader() {
    return Container(
      key: const ValueKey<bool>(true),
      color: const Color(0xFF1C1B1F),
      height: 55.92 + 102,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 55.92,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              alignment: Alignment.center,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, size: 24, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchController.clear();
                        Provider.of<CharacterProvider>(context, listen: false).clearSearch();
                      });
                    },
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, size: 28, color: Colors.white),
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
          ),
          // CAMPO DE BUSCA
          Positioned(
            top: 55.92,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              color: const Color(0xFF1C1B1F),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              alignment: Alignment.center,
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
    );
  }
}
