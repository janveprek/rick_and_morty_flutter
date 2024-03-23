import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

class CharacterDetailState {
  final CharacterDetail? character;
  final ScreenState state;

  const CharacterDetailState({
    this.character,
    this.state = const LoadingState(),
  });

  CharacterDetailState copyWith({
    CharacterDetail? character,
    ScreenState? state,
  }) {
    return CharacterDetailState(
      character: character ?? this.character,
      state: state ?? this.state,
    );
  }
}