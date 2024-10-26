import 'package:flutter/material.dart';

class Pixel extends StatefulWidget {
  final Color color;
  final Widget child;

  const Pixel({super.key, required this.color, required this.child});

  @override
  State<Pixel> createState() => _PixelState();
}

class _PixelState extends State<Pixel> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(4)

      ),
      margin: const EdgeInsets.all(1.0),
      child: widget.child,

    );
  }
}
