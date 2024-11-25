import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zrr_task/features/homepage/presentation/pages/homepage.dart';

import 'features/homepage/presentation/provider/country_provider.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountryProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Country Search App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:  HomePage(),
      ),
    );
  }
}


