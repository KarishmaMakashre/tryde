import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tryde/dummy_api_data/food/provider/food_provider.dart';
import 'package:tryde/providers/local_provider.dart';
import 'package:tryde/providers/location_provider.dart';
import 'providers/theme_provider.dart'; 
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  runApp(
    MultiProvider( 
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
        ChangeNotifierProvider(create: (context) => LocationProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()..loadTheme()), 
        ChangeNotifierProvider(create: (_) => MealProvider()..loadCategories())
      ],
      child: const MyApp(),
    ),
  );
}