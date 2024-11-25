import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:zrr_task/core/constants/locale_keys.dart';
import 'package:zrr_task/features/custom_widgets/custom_button.dart';
import 'package:zrr_task/features/custom_widgets/custom_text.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/constants.dart';
import '../../../../core/models/country_model.dart';
import '../../../custom_widgets/custom_text_field_widget.dart';
import '../provider/country_provider.dart';
import '../widgets/country_details_tile.dart';
import '../widgets/custom_rich_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  // Debounce logic for API call
  void _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();

    _debounce = Timer(AppConstants.debounceDuration, () {
      final query = _searchController.text.trim();
      if (query.isNotEmpty) {
        context
            .read<CountryProvider>()
            .fetchCountries(query); // Use context.read to trigger fetch
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const CustomText(
          text: LocaleKeys.countrySearch,
          color: Colors.white,
          fontWeight: FontWeight.w700,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CustomTextFieldWidget(
              controller: _searchController,
              hintText: LocaleKeys.searchForACountry,
              prefixIcon: const Icon(Icons.search),
              borderRadius: 12.0,
              textStyle: const TextStyle(fontSize: 16, color: Colors.black),
              hintStyle: const TextStyle(color: Colors.grey),
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: Consumer<CountryProvider>(
                builder: (context, countryProvider, child) {
                  if (countryProvider.isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (countryProvider.errorMessage.isNotEmpty) {
                    return Center(child: Text(countryProvider.errorMessage));
                  }

                  if (countryProvider.countries.isEmpty) {
                    return const Center(
                        child: Text(LocaleKeys.noCountriesFound));
                  }

                  return ListView.builder(
                    itemCount: countryProvider.countries.length,
                    itemBuilder: (context, index) {
                      final country = countryProvider.countries[index];
                      return CountryDetailsTile(
                        country: country,
                        onTap: () {
                          _showCountryDetails(country);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCountryDetails(CountryModel country) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        title: Text(country.commonName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(country.flagUrl),
            const SizedBox(height: 20),
            CustomRichText(
              title: '${LocaleKeys.population}: ',
              value: '${country.population}',
            ),
            const SizedBox(height: 10),
            CustomRichText(
              title: '${LocaleKeys.region}: ',
              value: country.region,
            ),
          ],
        ),
        actions: [
          CustomButton(text: LocaleKeys.close, isEnable: true, onPressed:  () => Navigator.of(context).pop(),)

        ],
      ),
    );
  }
}
