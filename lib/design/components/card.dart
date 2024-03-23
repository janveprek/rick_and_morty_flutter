import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/design/dimensions.dart';

import '../../character/model/character_model.dart';
import 'favorite_icon.dart';

class CharacterCard extends StatelessWidget {
  final CharacterModel character;
  final Function(int) onCharacterClick;
  final Function(CharacterModel) onCharacterLongClick;

  const CharacterCard({
    Key? key,
    required this.character,
    required this.onCharacterClick,
    required this.onCharacterLongClick,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(cornerRadiusMedium),
      ),
      child: InkWell(
        onTap: () {
          onCharacterClick(character.id.toInt());
        },
        onLongPress: () {
          onCharacterLongClick(character);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(cornerRadiusMedium),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.network(
                  character.iconUrl,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: paddingSmall),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      character.status,
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
            ),
            FavouriteIcon(
              isFavourite: character.isFavourite,
              onClick: () {
                onCharacterLongClick(character);
              },
            ),
          ],
        ),
      ),
    );
  }
}
