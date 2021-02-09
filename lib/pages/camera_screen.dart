import 'package:flutter/material.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          "This is our Camera",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
