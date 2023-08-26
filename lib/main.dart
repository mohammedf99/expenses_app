import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'widgets/expenses.dart';
import 'theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeLeft,
  ]).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: appDarkTheme,
      theme: appLightTheme,
      debugShowCheckedModeBanner: false,
      title: 'Expense App',
      themeMode: ThemeMode.system,
      home: const Expenses(),
    );
  }
}
