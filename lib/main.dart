import 'package:flutter/material.dart';
import 'package:lu/core/theme/app_theme.dart';
import 'package:lu/features/home/presentation/screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const LuciaBirthdayApp());
}

class LuciaBirthdayApp extends StatelessWidget {
  const LuciaBirthdayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Regalo para Lucía',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
    );
  }
}