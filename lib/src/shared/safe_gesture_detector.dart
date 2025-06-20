import 'package:flutter/material.dart';

class SafeGestureDetector extends StatefulWidget {
  const SafeGestureDetector({
    super.key,
    required this.child,
    required this.onTap,
    this.intervalMs = 500,
  });

  final Widget child;
  final Function() onTap;
  final int intervalMs;

  @override
  State<SafeGestureDetector> createState() => _SafeGestureDetectorState();
}

class _SafeGestureDetectorState extends State<SafeGestureDetector> {
  int lastTimeClicked = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      onTap: () {
        final now = DateTime.now().millisecondsSinceEpoch;
        if (now - lastTimeClicked < widget.intervalMs) {
          return;
        }
        lastTimeClicked = now;
        widget.onTap.call();
      },
      child: widget.child,
    );
  }
}
