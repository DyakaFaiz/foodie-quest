import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/recipe_provider.dart';
import 'providers/photo_provider.dart';
import 'screens/home_screen.dart';
import 'services/supabase_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  // Note: Ensure you have set your Supabase URL and Anon Key in lib/services/supabase_service.dart
  await SupabaseService.initialize();

  runApp(const FoodieQuestApp());
}

class FoodieQuestApp extends StatelessWidget {
  const FoodieQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => PhotoProvider()),
      ],
      child: MaterialApp(
        title: 'FoodieQuest',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
          useMaterial3: true,
          textTheme: const TextTheme(
            headlineSmall: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
