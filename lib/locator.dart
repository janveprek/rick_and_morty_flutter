
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:rick_and_morty_flutter/character/data/character_api.dart';
import 'package:rick_and_morty_flutter/character/data/character_db.dart';
import 'package:rick_and_morty_flutter/character/data/character_repository_impl.dart';
import 'package:rick_and_morty_flutter/character/domain/add_character_to_favorites.dart';
import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/domain/get_all_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/get_character_by_id_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/get_characters_by_name_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/get_favorite_characters_use_case.dart';
import 'package:rick_and_morty_flutter/character/domain/remove_character_from_favorites_use_case.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/character_detail_view_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/favorite/favorite_characters_view_model.dart';
import 'package:rick_and_morty_flutter/character/presentation/list/character_list_view_model.dart';
import 'package:rick_and_morty_flutter/character/system/character_api_impl.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerSingleton<Client>(Client());
  locator.registerSingleton<CharacterApi>(CharacterApiImpl(locator()));
  locator.registerSingleton<CharacterDatabase>(SQLiteCharacterDatabase());
  locator.registerSingleton<CharacterRepository>(
      CharacterRepositoryImpl(locator(), locator()));
  locator.registerSingleton<GetAllCharactersUseCase>(
      GetAllCharactersUseCaseImpl(locator()));
  locator.registerSingleton<GetCharactersByNameUseCase>(
      GetCharactersByNameUseCaseImpl(locator()));
  locator.registerSingleton<GetCharacterByIdUseCase>(
      GetCharacterByIdUseCaseImpl(locator()));
  locator.registerSingleton<GetFavoriteCharactersUseCase>(
      GetFavoriteCharactersUseCaseImpl(locator()));
  locator.registerSingleton<AddCharacterToFavoritesUseCase>(
      AddCharacterToFavoritesUseCaseImpl(locator()));
  locator.registerSingleton<RemoveCharacterFromFavoritesUseCase>(
      RemoveCharacterFromFavoritesUseCaseImpl(locator()));
  locator.registerFactoryParam<CharacterDetailViewModel, int, dynamic>(
    (param1, _) =>
        CharacterDetailViewModel(id: param1, getCharacterById: locator()),
  );
  locator.registerFactory<CharactersListViewModel>(
    () => CharactersListViewModel(
      getAllCharacters: locator(),
      getCharactersByName: locator(),
      addCharacterToFavorites: locator(),
      removeCharacterFromFavorites: locator(),
    ),
  );
  locator.registerFactory<FavoriteCharactersViewModel>(
    () => FavoriteCharactersViewModel(
      getFavoriteCharacters: locator(),
      addCharacterToFavorites: locator(),
      removeCharacterFromFavorites: locator(),
    ),
  );
}
