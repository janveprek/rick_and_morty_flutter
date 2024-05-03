import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/character/domain/get_character_by_id_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/state/character_detail_state.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

import '../../domain/add_character_to_favorites.dart';
import '../../domain/remove_character_from_favorites_use_case.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final int id;
  final GetCharacterByIdUseCase getCharacterById;
  final AddCharacterToFavoritesUseCase addCharacterToFavorites;
  final RemoveCharacterFromFavoritesUseCase removeCharacterFromFavorites;

  late CharacterDetailState _characterState;

  CharacterDetailState get characterState => _characterState;

  CharacterDetailViewModel({
    required this.id,
    required this.getCharacterById,
    required this.addCharacterToFavorites,
    required this.removeCharacterFromFavorites,
  }) {
    _characterState = const CharacterDetailState();
    getCharacter();
  }

  Future<void> getCharacter() async {
    var result = await getCharacterById(id);
    if (result is Success<CharacterDetail>) {
      _characterState = _characterState.copyWith(
        state: const SuccessState(),
        character: result.value,
      );
    } else if (result is Error) {
      _characterState = _characterState.copyWith(state: const ErrorState());
    }
    notifyListeners();
  }

  Future<void> toggleFavourite() async {
    final character = _characterState.character;
    if (character != null) {
      final characterModel = CharacterModel(id: character.id, name: character.name, status: character.status, iconUrl: character.iconUrl);
      if (character.isFavourite) {
        await removeCharacterFromFavorites(characterModel);
      } else {
        await addCharacterToFavorites(characterModel);
      }
      _characterState = _characterState.copyWith(character: character.copyWith(isFavourite: !character.isFavourite));
      notifyListeners();
    }
  }
}
