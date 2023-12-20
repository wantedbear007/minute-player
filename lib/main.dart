import 'package:flutter/material.dart';
import 'package:minute_player/screens/home_screen.dart';
import 'package:minute_player/utils/color_schemes.dart';
import 'package:minute_player/utils/file_manager.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
  // var x = await FileManager.getFolderWithFiles();

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(colorScheme: darkColorScheme),
      // home: Scaffold(
      //   body: Center(
      //     child: IconButton(
      //         icon: Icon(
      //           Icons.refresh,
      //           size: 70,
      //         ),
      //         onPressed: () {
      //           FileManager.getFolderWithFiles();
      //         }),
      //   ),
      // ),
      home: HomeScreen(),
    );
  }
}
