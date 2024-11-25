// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CountryModelImpl _$$CountryModelImplFromJson(Map<String, dynamic> json) =>
    _$CountryModelImpl(
      commonName: json['commonName'] as String,
      officialName: json['officialName'] as String,
      region: json['region'] as String,
      flagUrl: json['flagUrl'] as String,
      population: (json['population'] as num).toInt(),
    );

Map<String, dynamic> _$$CountryModelImplToJson(_$CountryModelImpl instance) =>
    <String, dynamic>{
      'commonName': instance.commonName,
      'officialName': instance.officialName,
      'region': instance.region,
      'flagUrl': instance.flagUrl,
      'population': instance.population,
    };
