import 'package:flutter/material.dart';
import 'package:minute_player/widgets/bottom_navigation.dart'
    show BottomNavigation;
import 'package:permission_handler/permission_handler.dart'
    show Permission, PermissionActions, PermissionStatus, openAppSettings;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _permissionGranted = false;

  // for permissions
  Future<void> _requestPermission() async {
    PermissionStatus status = await Permission.videos.status;

    if (status == PermissionStatus.granted) {
      setState(() {
        _permissionGranted = true;
      });
    } else {
      await Permission.videos.request();
      openAppSettings();
    }
  }

  @override
  void initState() {
    super.initState();
    _requestPermission();
  }

  @override
  Widget build(BuildContext context) {
    return _permissionGranted
        ? const BottomNavigation()
        : Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Requires Storage Permission ! Try again.",
                    style: TextStyle(fontSize: 15),
                  ),
                  IconButton(
                    onPressed: _requestPermission,
                    icon: const Icon(
                      Icons.refresh,
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
