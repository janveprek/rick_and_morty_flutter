import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/get_favorite_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/favorite_characters_view_model.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

import 'favorite_characters_viewmodel_test.mocks.dart';

@GenerateMocks([
  GetFavoriteCharactersUseCase,
  AddCharacterToFavoritesUseCase,
  RemoveCharacterFromFavoritesUseCase
])
void main() {
  MockGetFavoriteCharactersUseCase getFavoriteCharacters =
      MockGetFavoriteCharactersUseCase();
  MockAddCharacterToFavoritesUseCase addCharacterToFavourites =
      MockAddCharacterToFavoritesUseCase();
  MockRemoveCharacterFromFavoritesUseCase removeCharacterFromFavourites =
      MockRemoveCharacterFromFavoritesUseCase();

  group('FavoriteCharactersViewModel tests', () {
    test('should get characters during init', () async {
      final characterList = [
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: true)
      ];
      when(getFavoriteCharacters()).thenAnswer((_) async => characterList);
      final viewModel = FavoriteCharactersViewModel(
        getFavoriteCharacters: getFavoriteCharacters,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.getCharacters();

      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, characterList);
    });

    test('search should change screen state to empty', () async {
      when(getFavoriteCharacters()).thenAnswer((_) async => []);
      final viewModel = FavoriteCharactersViewModel(
        getFavoriteCharacters: getFavoriteCharacters,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.search('query');

      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const EmptyState());
      expect(viewModel.charactersState.characters, List.empty());
    });

    test('toggleFavourite should change screen state character', () async {
      final favCharacter = CharacterModel(
          id: 1,
          name: "Rick",
          status: "alive",
          iconUrl: "icon",
          isFavourite: false);
      final characterList = [
        favCharacter,
        CharacterModel(
            id: 2,
            name: "Morty",
            status: "alive",
            iconUrl: "",
            isFavourite: false)
      ];

      final updatedList = [
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: true),
        CharacterModel(
            id: 2,
            name: "Morty",
            status: "alive",
            iconUrl: "",
            isFavourite: false)
      ];
      when(getFavoriteCharacters()).thenAnswer((_) async => characterList);
      final viewModel = FavoriteCharactersViewModel(
        getFavoriteCharacters: getFavoriteCharacters,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      viewModel.toggleFavourite(favCharacter);

      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, updatedList);
      viewModel.toggleFavourite(favCharacter.copyWith(isFavourite: true));
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.characters, characterList);
    });

    test('search should change screen state', () async {
      final characterList = [
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: false),
        CharacterModel(
            id: 2,
            name: "Morty",
            status: "alive",
            iconUrl: "",
            isFavourite: false)
      ];
      when(getFavoriteCharacters()).thenAnswer((_) async => characterList);
      final viewModel = FavoriteCharactersViewModel(
        getFavoriteCharacters: getFavoriteCharacters,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.search('rick');

      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, [characterList[0]]);
    });

    test('search should not change state if query is empty', () async {
      final characterList = [
        CharacterModel(
          id: 1,
          name: "Rick",
          status: "alive",
          iconUrl: "",
          isFavourite: false,
        ),
        CharacterModel(
          id: 2,
          name: "Morty",
          status: "alive",
          iconUrl: "",
          isFavourite: false,
        ),
      ];

      when(getFavoriteCharacters()).thenAnswer((_) async => characterList);
      final viewModel = FavoriteCharactersViewModel(
        getFavoriteCharacters: getFavoriteCharacters,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      const emptyQuery = "";
      await Future.delayed(Duration.zero);
      viewModel.search(emptyQuery);
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, characterList);
    });
  });
}
