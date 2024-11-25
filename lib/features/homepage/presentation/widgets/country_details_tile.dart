import 'package:flutter/material.dart';

import '../../../../core/models/country_model.dart';
import '../../../custom_widgets/custom_text.dart';


class CountryDetailsTile extends StatelessWidget {
  final CountryModel country;
  final VoidCallback onTap;

  const CountryDetailsTile({
    Key? key,
    required this.country,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        country.flagUrl,
        width: 40,
      ),
      title: CustomText(
        text: country.officialName,
        maxLines: 1,
        textOverflow: TextOverflow.ellipsis,
      ),
      subtitle: CustomText(
        text: country.region,
        size: 14,
      ),
      onTap: onTap,
    );
  }
}
