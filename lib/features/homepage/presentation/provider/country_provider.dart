import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:zrr_task/core/constants/locale_keys.dart';
import 'dart:convert';

import '../../../../core/constants/constants.dart';
import '../../../../core/models/country_model.dart';

class CountryProvider with ChangeNotifier {
  List<CountryModel> _countries = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<CountryModel> get countries => _countries;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> fetchCountries(String query) async {
    if (query.isEmpty) {
      _countries = [];
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    // final url = Uri.parse('${AppConstants.apiBaseUrl}.${AppConstants.countrySearchEndpoint}/$query');
    final url = Uri.parse('https://restcountries.com/v3.1/name/$query');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        if (data.isEmpty) {
          _countries = [];
          _errorMessage = LocaleKeys.noCountriesFound;
        } else {
          _countries = data
              .map((countryData) => CountryModel.fromJson(countryData))
              .toList();
        }
      } else {
        _errorMessage = LocaleKeys.unableToFetchData;
      }
    } catch (error) {
      _errorMessage = LocaleKeys.anErrorOccurredPleaseTryAgain;
    }

    _isLoading = false;
    notifyListeners();
  }
}
