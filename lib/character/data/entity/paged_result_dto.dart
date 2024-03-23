import 'dart:core';

import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

import 'character_dto.dart';

part 'paged_result_dto.g.dart';

@JsonSerializable()
class PagedResultDto {
  @JsonKey(name: 'results')
  final List<CharacterDto> result;

  PagedResultDto({required this.result});

  factory PagedResultDto.fromJson(Map<String, dynamic> json) => _$PagedResultDtoFromJson(json);

  Map<String, dynamic> toJson() => _$PagedResultDtoToJson(this);

  PagedResult toModel() {
    return PagedResult(data: result.map((item) => item.toModel()).toList());
  }
}

class PagedResult {
  List<CharacterModel> data;

  PagedResult({required this.data});
}
