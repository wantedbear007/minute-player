import 'package:flutter/material.dart';
import 'package:minute_player/screens/home_screen.dart';
import 'package:minute_player/utils/color_schemes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      home: HomeScreen(),
    );
  }
}
