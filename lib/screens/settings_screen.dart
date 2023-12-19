import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'App Settings',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            _buildSettingItem('Dark Mode', 'Coming Soon...'),
            _buildSettingItem('Notifications', 'Ask your pet parrot for updates'),
            _buildSettingItem('Language', 'Pig Latin (Oinkway Oinkway)'),
            _buildSettingItem('Profile Picture', 'Upload a selfie...of your cat'),
            _buildSettingItem('About Us', 'We are a team of highly trained squirrels'),
          ],
        ),
      ),
    );


  }
  Widget _buildSettingItem(String title, String placeholder) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4),
          Text(
            placeholder,
            style: TextStyle(
              fontStyle: FontStyle.italic,
              color: Colors.grey,
            ),
          ),
          Divider(),
        ],
      ),
    );
  }
}
