
import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

import '../dimensions.dart';

class CharacterSearchList extends StatelessWidget {
  final List<CharacterModel> characters;
  final void Function(int) onCharacterClick;

  const CharacterSearchList({
    Key? key,
    required this.characters,
    required this.onCharacterClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: paddingSmall),
      itemCount: characters.length,
      itemBuilder: (context, index) {
        final character = characters[index];
        return CharacterItem(
          character: character,
          onCharacterClick: onCharacterClick,
        );
      },
    );
  }
}

class CharacterItem extends StatelessWidget {
  final CharacterModel character;
  final void Function(int) onCharacterClick;

  const CharacterItem({
    Key? key,
    required this.character,
    required this.onCharacterClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onCharacterClick(character.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(cornerRadiusMedium),
          color: Colors.grey, // Set your desired color
        ),
        margin: const EdgeInsets.symmetric(vertical: paddingSmall),
        padding: const EdgeInsets.all(paddingSmall),
        child: Text(
          character.name,
        ),
      ),
    );
  }
}
