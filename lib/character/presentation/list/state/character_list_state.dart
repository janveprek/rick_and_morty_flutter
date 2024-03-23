
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';

import '../../../../design/model/screen_state.dart';

class CharacterListState {
  final List<CharacterModel> characters;
  final String query;
  final bool openBottomSheet;
  final StatusFilter appliedFilter;
  final ScreenState state;

  const CharacterListState({
    this.characters = const [],
    this.query = "",
    this.openBottomSheet = false,
    this.appliedFilter = StatusFilter.all,
    this.state = const LoadingState(),
  });


  CharacterListState copyWith({
    List<CharacterModel>? characters,
    String? query,
    bool? openBottomSheet,
    StatusFilter? appliedFilter,
    ScreenState? state,
  }) {
    return CharacterListState(
      characters: characters ?? this.characters,
      query: query ?? this.query,
      openBottomSheet: openBottomSheet ?? this.openBottomSheet,
      appliedFilter: appliedFilter ?? this.appliedFilter,
      state: state ?? this.state,
    );
  }
}