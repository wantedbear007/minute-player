import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minute_player/utils/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _screenNumber = 0;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Theme.of(context).colorScheme.surface,
      ),
      child: Scaffold(
        appBar: AppBar(title: Text("this is home screen")),
        body: homeScreenPages[_screenNumber],
        bottomNavigationBar: NavigationBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          shadowColor: Theme.of(context).colorScheme.shadow,
          elevation: 3,
          onDestinationSelected: (int index) {
            setState(() {
              _screenNumber = index;
            });
          },
          selectedIndex: _screenNumber,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.video_collection_outlined),
              label: "Videos",
              selectedIcon: Icon(Icons.ondemand_video_sharp),
              tooltip: "Video files",
            ),
            NavigationDestination(
              icon: Icon(Icons.settings),
              label: "Settings",
              tooltip: "Settings",
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {},
        ),
      ),
    );
  }
}
