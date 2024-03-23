import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

abstract class GetCharacterByIdUseCase {
  Future<ResultWrapper<CharacterDetail>> call(int id);
}

class GetCharacterByIdUseCaseImpl implements GetCharacterByIdUseCase {
  final CharacterRepository repository;

  GetCharacterByIdUseCaseImpl(this.repository);

  @override
  Future<ResultWrapper<CharacterDetail>> call(int id) async {
    return repository.getCharacterById(id);
  }
}
