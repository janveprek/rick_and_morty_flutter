import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/get_all_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/get_characters_by_name_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';
import 'state/character_list_state.dart';

var logger = Logger();

class CharactersListViewModel extends ChangeNotifier {
  final GetAllCharactersUseCase getAllCharacters;
  final GetCharactersByNameUseCase getCharactersByName;
  final AddCharacterToFavoritesUseCase addCharacterToFavorites;
  final RemoveCharacterFromFavoritesUseCase removeCharacterFromFavorites;

  CharactersListViewModel({
    required this.getAllCharacters,
    required this.getCharactersByName,
    required this.addCharacterToFavorites,
    required this.removeCharacterFromFavorites,
  }) {
    updateCharacters();
  }

  CharacterListState _charactersState = const CharacterListState();

  CharacterListState get charactersState => _charactersState;

  void updateCharacters() async {
    _charactersState = _charactersState.copyWith(state: const LoadingState());
    notifyListeners();

    var result = await getAllCharacters();
    if (result is Success<List<CharacterModel>>) {
      _charactersState = _charactersState.copyWith(
        state: const SuccessState(),
        characters: result.value,
      );
    } else if (result is Error) {
      _charactersState = _charactersState.copyWith(state: const ErrorState());
    }
    notifyListeners();
  }

  void toggleFavourite(CharacterModel character) async {
    var index = _charactersState.characters.indexOf(character);

    if (index != -1) {
      var updatedCharacter = _charactersState.characters[index].copyWith(
          isFavourite: !_charactersState.characters[index].isFavourite);

      if (updatedCharacter.isFavourite) {
        await addCharacterToFavorites(updatedCharacter);
      } else {
        await removeCharacterFromFavorites(updatedCharacter);
      }

      var updatedCharacters =
          List<CharacterModel>.from(_charactersState.characters);
      updatedCharacters[index] = updatedCharacter;
      _charactersState =
          _charactersState.copyWith(characters: updatedCharacters);
      notifyListeners();
    }
  }

  void search(String query) async {
    if (query.isNotEmpty) {
      _charactersState = _charactersState.copyWith(state: const LoadingState());
      notifyListeners();

      var result = await getCharactersByName(query,
          filter: _charactersState.appliedFilter);
      if (result is Success<List<CharacterModel>>) {
        var characters = result.value;
        _charactersState = _charactersState.copyWith(
          state:
              characters.isNotEmpty ? const SuccessState() : const EmptyState(),
          query: query,
          characters: characters,
        );
      } else if (result is Error) {
        _charactersState = _charactersState.copyWith(state: const ErrorState());
      }
      notifyListeners();
    }
  }

  void applyFilter(StatusFilter filter) {
    _charactersState = _charactersState.copyWith(appliedFilter: filter);
    search(_charactersState.query);
    notifyListeners();
  }

  void openBottomSheet() {
    _charactersState = _charactersState.copyWith(openBottomSheet: true);
    notifyListeners();
  }

  void closeBottomSheet() {
    _charactersState = _charactersState.copyWith(openBottomSheet: false);
    notifyListeners();
  }
}
