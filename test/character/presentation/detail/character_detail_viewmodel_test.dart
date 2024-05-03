import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/get_character_by_id_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/character_detail_view_model.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

import 'character_detail_viewmodel_test.mocks.dart';

@GenerateMocks([GetCharacterByIdUseCase, AddCharacterToFavoritesUseCase, RemoveCharacterFromFavoritesUseCase])
void main() {
  MockGetCharacterByIdUseCase getCharacterById = MockGetCharacterByIdUseCase();
  MockAddCharacterToFavoritesUseCase addCharacterToFavourites = MockAddCharacterToFavoritesUseCase();
  MockRemoveCharacterFromFavoritesUseCase removeCharacterFromFavourites = MockRemoveCharacterFromFavoritesUseCase();

  group('CharacterDetailViewModel tests', ()
  {
    test('should get character', () async {
      final character = CharacterDetail(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: "origin",
        location: "location",
        iconUrl: "icon",
      );
      when(getCharacterById(any)).thenAnswer((_) async => Success(character));
      final viewModel = CharacterDetailViewModel(
        getCharacterById: getCharacterById,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
        id: 1,
      );

      expect(viewModel.characterState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.characterState.state, const SuccessState());
      expect(viewModel.characterState.character, character);
    });

    test('getCharacter should show error screen state', () async {
      when(getCharacterById(any)).thenAnswer((_) async => Error(Exception()));
      final viewModel = CharacterDetailViewModel(
        getCharacterById: getCharacterById,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
        id: 1,
      );

      expect(viewModel.characterState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.characterState.state, const ErrorState());
    });

    test('toggleFavourite should change screen state character', () async {
      final characterDetail = CharacterDetail(
        id: 1,
        name: "Rick",
        status: "alive",
        species: "species",
        type: "type",
        gender: "gender",
        origin: "origin",
        location: "location",
        iconUrl: "icon",
      );
      when(getCharacterById(any)).thenAnswer((_) async =>
          Success(characterDetail));
      final viewModel = CharacterDetailViewModel(
        getCharacterById: getCharacterById,
        addCharacterToFavorites: addCharacterToFavourites,
        removeCharacterFromFavorites: removeCharacterFromFavourites,
        id: 1,
      );
      viewModel.toggleFavourite();

      expect(viewModel.characterState.state, const LoadingState());
      await Future.delayed(Duration.zero);
      expect(viewModel.characterState.character,
          characterDetail.copyWith(isFavourite: true));

      viewModel.toggleFavourite();
      await Future.delayed(Duration.zero);
      expect(viewModel.characterState.character,
          characterDetail.copyWith(isFavourite: false));
    });
  });
}