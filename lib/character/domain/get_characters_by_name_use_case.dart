import 'package:rick_and_morty_flutter/character/domain/character_repository.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';
import 'package:rick_and_morty_flutter/character/model/filter.dart';
import 'package:rick_and_morty_flutter/character/model/result_wrapper.dart';

abstract class GetCharactersByNameUseCase {
  Future<ResultWrapper<List<CharacterModel>>> call(String name, {StatusFilter filter =  StatusFilter.all});
}

class GetCharactersByNameUseCaseImpl implements GetCharactersByNameUseCase {
  final CharacterRepository repository;

  GetCharactersByNameUseCaseImpl(this.repository);

  @override
  Future<ResultWrapper<List<CharacterModel>>> call(String name, {StatusFilter filter =  StatusFilter.all}) async {
    return repository.getCharactersByName(name, filter: filter);
  }
}
