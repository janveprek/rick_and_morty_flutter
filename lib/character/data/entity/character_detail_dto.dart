import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty_flutter/character/model/character_detail.dart';

part 'character_detail_dto.g.dart';

@JsonSerializable()
class CharacterDetailDto {
  @JsonKey(name: 'id')
  final int id;

  @JsonKey(name: 'name')
  final String name;

  @JsonKey(name: 'status')
  final String status;

  @JsonKey(name: 'species')
  final String species;

  @JsonKey(name: 'type')
  final String type;

  @JsonKey(name: 'gender')
  final String gender;

  @JsonKey(name: 'origin')
  final OriginDto origin;

  @JsonKey(name: 'location')
  final LocationDto location;

  @JsonKey(name: 'image')
  final String image;

  CharacterDetailDto({required this.id, required this.name, required this.status, required this.species, required this.type, required this.gender, required this.origin, required this.location, required this.image});

  factory CharacterDetailDto.fromJson(Map<String, dynamic> json) => _$CharacterDetailDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CharacterDetailDtoToJson(this);

  CharacterDetail toModel() {
    return CharacterDetail(
      id: id,
      name: name,
      status: status,
      species: species,
      type: type,
      gender:gender,
      origin: origin.name,
      location: location.name,
      iconUrl: image,
    );
  }
}

@JsonSerializable()
class OriginDto {
  final String name;

  OriginDto({required this.name});

  factory OriginDto.fromJson(Map<String, dynamic> json) => _$OriginDtoFromJson(json);
  Map<String, dynamic> toJson() => _$OriginDtoToJson(this);
}

@JsonSerializable()
class LocationDto {
  final String name;

  LocationDto({required this.name});

  factory LocationDto.fromJson(Map<String, dynamic> json) => _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}