import 'package:flutter/material.dart';

class Map extends StatefulWidget {

  Map({super.key, required this.color});

  Color color;

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(4)

      ),
      margin: const EdgeInsets.all(1.0),
    );
  }
}
