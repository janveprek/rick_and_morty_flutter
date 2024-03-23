import 'package:flutter/material.dart';
import 'package:rick_and_morty_flutter/character/domain/get_character_by_id_use_case.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';
import 'package:rick_and_morty_flutter/character/presentation/detail/state/character_detail_state.dart';
import 'package:rick_and_morty_flutter/design/model/screen_state.dart';

class CharacterDetailViewModel extends ChangeNotifier {
  final int id;
  final GetCharacterByIdUseCase getCharacterById;

  late CharacterDetailState _characterState;
  CharacterDetailState get characterState => _characterState;

  CharacterDetailViewModel({required this.id, required this.getCharacterById}) {
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
}
