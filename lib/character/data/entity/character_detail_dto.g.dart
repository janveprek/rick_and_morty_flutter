// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'character_detail_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CharacterDetailDto _$CharacterDetailDtoFromJson(Map<String, dynamic> json) =>
    CharacterDetailDto(
      id: json['id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      type: json['type'] as String,
      gender: json['gender'] as String,
      origin: OriginDto.fromJson(json['origin'] as Map<String, dynamic>),
      location: LocationDto.fromJson(json['location'] as Map<String, dynamic>),
      image: json['image'] as String,
    );

Map<String, dynamic> _$CharacterDetailDtoToJson(CharacterDetailDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'status': instance.status,
      'species': instance.species,
      'type': instance.type,
      'gender': instance.gender,
      'origin': instance.origin,
      'location': instance.location,
      'image': instance.image,
    };

OriginDto _$OriginDtoFromJson(Map<String, dynamic> json) => OriginDto(
      name: json['name'] as String,
    );

Map<String, dynamic> _$OriginDtoToJson(OriginDto instance) => <String, dynamic>{
      'name': instance.name,
    };

LocationDto _$LocationDtoFromJson(Map<String, dynamic> json) => LocationDto(
      name: json['name'] as String,
    );

Map<String, dynamic> _$LocationDtoToJson(LocationDto instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
