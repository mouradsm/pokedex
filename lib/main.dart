import 'package:flutter/material.dart';
import 'package:pokedex/pages/home_page.dart';

void main() {
  runApp(const MainApp());
}

class PokemonPage extends StatelessWidget {
  const PokemonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}
