// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
part of 'paged_result_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResultDto _$PagedResultDtoFromJson(Map<String, dynamic> json) =>
    PagedResultDto(
      result: (json['results'] as List<dynamic>)
          .map((e) => CharacterDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PagedResultDtoToJson(PagedResultDto instance) =>
    <String, dynamic>{
      'results': instance.result,
    };
