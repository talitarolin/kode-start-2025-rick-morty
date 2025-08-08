// lib/main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kode_start_2025_rick_morty/core/theme/app_theme.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/models/character_model.dart';
import 'package:kode_start_2025_rick_morty/features/character/data/providers/character_provider.dart';
import 'package:kode_start_2025_rick_morty/features/character/presentation/screens/character_detail_screen.dart';
import 'package:kode_start_2025_rick_morty/features/character/presentation/screens/character_list_screen.dart';
import 'package:kode_start_2025_rick_morty/routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CharacterProvider()),
      ],
      child: MaterialApp(
        title: 'Rick and Morty App',
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.home,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case AppRoutes.home:
              return MaterialPageRoute(builder: (_) => const CharacterListScreen());
            case AppRoutes.characterDetail:
              final character = settings.arguments as CharacterModel;
              return MaterialPageRoute(
                builder: (_) => CharacterDetailScreen(character: character),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}