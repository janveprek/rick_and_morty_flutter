import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_flutter/character/model/character_model.dart';

part 'character_dto.g.dart';

@JsonSerializable()
class CharacterDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'image')
  final String image;

  CharacterDto({required this.id, required this.name, required this.status, required this.image});

  factory CharacterDto.fromJson(Map<String, dynamic> json) => _$CharacterDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CharacterDtoToJson(this);

  CharacterModel toModel() {
    return CharacterModel(
      id: id,
      name: name,
      status: status,
      iconUrl: image,
    );
  }
}
