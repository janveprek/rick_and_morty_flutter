import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/get_all_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/get_characters_by_name_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';
import 'package:rick_and_morty_flutter/character/presentation/list/character_list_view_model.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

import 'list_characters_viewmodel_test.mocks.dart';

@GenerateMocks([
  GetAllCharactersUseCase,
  GetCharactersByNameUseCase,
  AddCharacterToFavoritesUseCase,
  RemoveCharacterFromFavoritesUseCase
])
void main() {
  MockGetAllCharactersUseCase getAllCharacters = MockGetAllCharactersUseCase();
  MockGetCharactersByNameUseCase getCharactersByName =
      MockGetCharactersByNameUseCase();
  MockAddCharacterToFavoritesUseCase addCharacterToFavourites =
      MockAddCharacterToFavoritesUseCase();
  MockRemoveCharacterFromFavoritesUseCase removeCharacterFromFavourites =
      MockRemoveCharacterFromFavoritesUseCase();

  group('ListCharactersViewModel tests', () {
    test('should get characters during init', () async {
      final characterList = [
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: true)
      ];
      when(getAllCharacters()).thenAnswer((_) async => Success(characterList));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, characterList);
    });

    test('updateCharacters should change screen state', () async {
      final characterList = [
        CharacterModel(
            id: 1,
            name: "Rick",
            status: "alive",
            iconUrl: "icon",
            isFavourite: true)
      ];
      when(getAllCharacters()).thenAnswer((_) async => Success(characterList));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      await Future.delayed(Duration.zero);
      viewModel.updateCharacters();
      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      expect(viewModel.charactersState.characters, characterList);
    });

    test('search should change screen state to empty', () async {
      when(getAllCharacters()).thenAnswer((_) async => Success([]));
      when(getCharactersByName(any)).thenAnswer((_) async => Success([]));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.search("name");

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
      when(getAllCharacters()).thenAnswer((_) async => Success(characterList));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
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
      when(getAllCharacters()).thenAnswer((_) async => Success([]));
      when(getCharactersByName(any))
          .thenAnswer((_) async => Success([characterList[0]]));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.search('rick');

      expect(viewModel.charactersState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const SuccessState());
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.characters, [characterList[0]]);
    });

    test('search should show error screen state', () async {
      const query = 'query';
      when(getAllCharacters()).thenAnswer((_) async => Success([]));
      when(getCharactersByName(query))
          .thenAnswer((_) async => Error(Exception()));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.search(query);
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const ErrorState());
    });

    test('updateCharacters should show error screen state', () async {
      when(getAllCharacters()).thenAnswer((_) async => Error(Exception()));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      viewModel.updateCharacters();
      await Future.delayed(Duration.zero);
      expect(viewModel.charactersState.state, const ErrorState());
    });

    test('openBottomSheet should change state', () async {
      when(getAllCharacters()).thenAnswer((_) async => Success([]));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );
      expect(viewModel.charactersState.openBottomSheet, false);
      viewModel.openBottomSheet();
      expect(viewModel.charactersState.openBottomSheet, true);
      await Future.delayed(Duration.zero);
    });

    test('closeBottomSheet should change state', () async {
      when(getAllCharacters()).thenAnswer((_) async => Success([]));
      final viewModel = CharactersListViewModel(
        getAllCharacters: getAllCharacters,
        getCharactersByName: getCharactersByName,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
      );

      viewModel.openBottomSheet();
      expect(viewModel.charactersState.openBottomSheet, true);
      viewModel.closeBottomSheet();
      expect(viewModel.charactersState.openBottomSheet, false);
      await Future.delayed(Duration.zero);
    });
  });

  test('applyFilters should change state', () async {
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
    when(getAllCharacters()).thenAnswer((_) async => Success([]));
    when(getCharactersByName.call(any, filter:  anyNamed('filter'))).thenAnswer((_) async => Success(characterList));
    final viewModel = CharactersListViewModel(
      getAllCharacters: getAllCharacters,
      getCharactersByName: getCharactersByName,
      addCharacterToFavorites: addCharacterToFavourites,
      removeCharacterFromFavorites: removeCharacterFromFavourites,
    );
    expect(viewModel.charactersState.state, equals(const LoadingState()));
    expect(viewModel.charactersState.appliedFilter, StatusFilter.all);

    viewModel.applyFilter(StatusFilter.unknown);
    await Future.delayed(Duration.zero);
    expect(viewModel.charactersState.state, equals(const SuccessState()));
    expect(viewModel.charactersState.appliedFilter, StatusFilter.unknown);
  });
}
