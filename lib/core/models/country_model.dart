import 'package:freezed_annotation/freezed_annotation.dart';
part 'country_model.freezed.dart';
part 'country_model.g.dart';

@freezed
class CountryModel with _$CountryModel {
  const factory CountryModel({
    required String commonName,
    required String officialName,
    required String region,
    required String flagUrl,
    required int population,
  }) = _CountryModel;

  factory CountryModel.fromJson(Map<String, dynamic> json) => _$CountryModelFromJson({
    'commonName': json['name']['common'],
    'officialName': json['name']['official'],
    'region': json['region'],
    'flagUrl': json['flags']['png'],
    'population': json['population'],
  });
}
