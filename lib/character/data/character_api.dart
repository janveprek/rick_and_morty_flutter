

import 'package:rick_and_morty_flutter/character/data/entity/character_detail_dto.dart';
import 'package:rick_and_morty_flutter/character/data/entity/paged_result_dto.dart';

import '../model/filter.dart';

abstract class CharacterApi {
  Future<PagedResultDto> getAllCharacters({int page = 1});

  Future<PagedResultDto> getCharactersByName(String name, {StatusFilter filter =  StatusFilter.all});

  Future<CharacterDetailDto> getCharacterById(int id);
}