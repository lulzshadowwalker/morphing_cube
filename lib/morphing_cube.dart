import 'package:flutter/material.dart';
import 'package:morphing_cube/views/home/home.dart';

class MorphingCube extends StatelessWidget {
  const MorphingCube({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Morphing Cube',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
