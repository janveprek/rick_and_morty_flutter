import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rick_and_morty_flutter/character/presentation/list/character_list_screen.dart';
import 'package:rick_and_morty_flutter/design/theme.dart';
import 'locator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  setupLocator();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick and Morty App',
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
          useMaterial3: true,
          textTheme: const RickAndMortyTheme().textTheme,
          colorScheme: RickAndMortyTheme.lightScheme().toColorScheme()),
      darkTheme: ThemeData(
          useMaterial3: true,
          textTheme: const RickAndMortyTheme().textTheme,
          colorScheme: RickAndMortyTheme.darkScheme().toColorScheme()),
      home: const CharacterListScreen(),
    );
  }
}
