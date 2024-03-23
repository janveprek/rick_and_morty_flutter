import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rick_and_morty_flutter/character/data/character_api.dart';
import 'package:rick_and_morty_flutter/character/data/entity/character_detail_dto.dart';

import '../data/entity/paged_result_dto.dart';
import '../model/filter.dart';

class CharacterApiImpl implements CharacterApi {
  final http.Client httpClient;

  CharacterApiImpl(this.httpClient);

  @override
  Future<PagedResultDto> getAllCharacters({int page = 1}) async {
    final response = await httpClient.get(
      Uri.parse('https://rickandmortyapi.com/api/character/?page=$page'),
    );
    return PagedResultDto.fromJson(json.decode(response.body));
  }

  @override
  Future<PagedResultDto> getCharactersByName(String name, {StatusFilter filter = StatusFilter.all}) async {
    final response = await httpClient.get(
      Uri.parse('https://rickandmortyapi.com/api/character/?name=$name&status=${filter.apiName}'),
    );
    return PagedResultDto.fromJson(json.decode(response.body));
  }

  @override
  Future<CharacterDetailDto> getCharacterById(int id) async {
    final response = await httpClient.get(
      Uri.parse('https://rickandmortyapi.com/api/character/$id'),
    );
    return CharacterDetailDto.fromJson(json.decode(response.body));
  }
}
