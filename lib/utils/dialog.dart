import 'package:flutter/material.dart';

class Dialogs {
  static Center showLoading(String description) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
