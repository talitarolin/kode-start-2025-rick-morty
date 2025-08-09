import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/models/character_model.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final VoidCallback onTap;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: const Color(0xFF1B2B33),
        elevation: 4,
        child: Stack(
          children: [
            // Imagem do Personagem (parte inferior do Stack)
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  character.image,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                ),
              ),
            ),
            // Card Azul sobreposto (parte superior do Stack)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  color: Color(0xFF87A1FA),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                ),
              ),
            ),
            // Nome do Personagem (posicionado sobre o card azul)
            Positioned(
              bottom: 11.5, // Altura do card (40) - (14.5 / 2) - padding, ajustado para centralizar
              left: 6, // Padding left
              child: Text(
                character.name.toUpperCase(),
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 14.5,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}