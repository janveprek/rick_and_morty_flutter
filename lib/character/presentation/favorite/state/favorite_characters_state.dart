import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

class FavoriteCharactersState {
  final List<CharacterModel> characters;
  final ScreenState state;

  FavoriteCharactersState({
    this.characters = const [],
    this.state = const LoadingState(),
  });

  FavoriteCharactersState copyWith({
    List<CharacterModel>? characters,
    ScreenState? state,
  }) {
    return FavoriteCharactersState(
      characters: characters ?? this.characters,
      state: state ?? this.state,
    );
  }
}
