

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minute_player/utils/file_manager.dart';



class BottomNavBar extends StatelessWidget {
  const BottomNavBar(
      {super.key,
      required this.body,
      required this.selectedIndex,
      required this.onDestinationSelected});

  final Widget body;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: () async {
        print("yayya");

         const platform = MethodChannel('samples.flutter.dev/battery');


        // FileManager.getAllStorageList().then((value) => print(value));

       //FileManager.getStoragePaths().then((value) => print(value));
      // FileManager.tempGetFiles().then((value) => print(value.toString() + '\n'));
       //FileManager.getAllFilesInPath("/storage/emulated/0/").then((value) => print(value));
        final result = await platform.invokeMethod('getBatteryLevel',{"args" : "bhanu"});
        print(result.toString());
      },),
      body: body,
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedIndex,
        destinations: const [
          NavigationDestination(
            label: 'Home',
            icon: Icon(
              Icons.home,
            ),
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite),
            label: "Favourites",
          ),
          NavigationDestination(
            label: 'Settings',
            icon: Icon(Icons.settings),
          ),
        ],
        onDestinationSelected: onDestinationSelected,
      ),
    );
  }
}
