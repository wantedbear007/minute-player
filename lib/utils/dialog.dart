import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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

  static Center showSvg(String filePath, String description, double height) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            filePath,
            height: height,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(description),
          )
        ],
      ),
    );
  }
}
