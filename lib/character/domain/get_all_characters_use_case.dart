import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

abstract class GetAllCharactersUseCase {
  Future<ResultWrapper<List<CharacterModel>>> call({int page = 0});
}

class GetAllCharactersUseCaseImpl implements GetAllCharactersUseCase {
  final CharacterRepository repository;

  GetAllCharactersUseCaseImpl(this.repository);

  @override
  Future<ResultWrapper<List<CharacterModel>>> call({int page = 0}) async {
    return repository.getAllCharacters(page: page);
  }
}