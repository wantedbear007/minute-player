import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:go_router/go_router.dart';
import 'package:minute_player/utils/bottom_nav_bar.dart';
import 'package:minute_player/utils/bottom_nav_rail.dart';

import '../utils/global_variables.dart';



class NavigationBars extends StatelessWidget {
  const NavigationBars({Key? key, required this.navigationShell}):super(
  key: key ?? const ValueKey<String>('minutePlayerNav'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }


  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return BottomNavBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      } else {
        return SideNavRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
        );
      }
    });
  }
}




//
// class BottomNavigation extends StatefulWidget {
//   const BottomNavigation({super.key, required this.body});
//   final Widget body;
//
//
//   @override
//   State<BottomNavigation> createState() => _BottomNavigationState();
// }
//
// class _BottomNavigationState extends State<BottomNavigation> {
//   int _screenNumber = 0;
//
//   @override
//   Widget build(BuildContext context) {
//     return AnnotatedRegion<SystemUiOverlayStyle>(
//       value: SystemUiOverlayStyle(
//         systemNavigationBarColor: Theme.of(context).colorScheme.surface,
//       ),
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Media Files"),
//         ),
//         body: homeScreenPages[_screenNumber],
//         bottomNavigationBar: NavigationBar(
//           backgroundColor: Theme.of(context).colorScheme.surface,
//           shadowColor: Theme.of(context).colorScheme.shadow,
//           elevation: 3,
//           onDestinationSelected: (int index) {
//             setState(() {
//               _screenNumber = index;
//             });
//           },
//           selectedIndex: _screenNumber,
//           destinations: const <Widget>[
//             NavigationDestination(
//               icon: Icon(Icons.video_collection_outlined),
//               label: "Videos",
//               selectedIcon: Icon(Icons.ondemand_video_sharp),
//               tooltip: "Video files",
//             ),
//             NavigationDestination(
//               icon: Icon(Icons.settings),
//               label: "Settings",
//               tooltip: "Settings",
//             )
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {},
//         ),
//       ),
//     );
//     ;
//   }
// }
