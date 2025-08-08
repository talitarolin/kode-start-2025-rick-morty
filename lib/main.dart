import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'features/character/data/models/character_model.dart';
import 'features/character/presentation/screens/character_list_screen.dart';
import 'features/character/presentation/screens/character_detail_screen.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty App',
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.characterList,
      routes: {
        AppRoutes.characterList: (context) => const CharacterListScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == AppRoutes.characterDetail) {
          final CharacterModel character = settings.arguments as CharacterModel;
          return MaterialPageRoute(
            builder: (context) => CharacterDetailScreen(character: character),
          );
        }
        return null;
      },
    );
  }
}