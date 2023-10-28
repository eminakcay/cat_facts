import 'package:cat_facts/core/constants/constants.dart';
import 'package:cat_facts/features/home/presentation/screen/home_screen.dart';
import 'package:cat_facts/features/home/presentation/provider/home_provider.dart';
import 'package:cat_facts/locator.dart';
import 'package:cat_facts/utils/app_context.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  await initializeDependencies();

  runApp(
    ChangeNotifierProvider(
      create: (context) => HomeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: locator<AppContext>().navigatorKey,
      title: APP_NAME,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
