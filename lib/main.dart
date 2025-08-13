import 'package:flutter/material.dart';
import 'package:pak_independence_day_14_august/core/theme/app_theme.dart';
import 'package:pak_independence_day_14_august/presentation/providers/animation_provider.dart';
import 'package:pak_independence_day_14_august/presentation/screens/independence_day_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => AnimationProvider())],
      child: MaterialApp(
        title: 'Pakistan Independence Day',
        theme: AppTheme.lightTheme,
        debugShowCheckedModeBanner: false,
        home: const IndependenceDayScreen(),
      ),
    );
  }
}
