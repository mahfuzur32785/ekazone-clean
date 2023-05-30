import 'dart:async';

import 'package:flutter/material.dart';

class DelayedTopBottomAnimation extends StatefulWidget {
  final Widget child;
  final int delay;

  const DelayedTopBottomAnimation({Key? key,required this.child, required this.delay}) : super(key: key);

  @override
  DelayedTopBottomAnimationState createState() => DelayedTopBottomAnimationState();
}

class DelayedTopBottomAnimationState extends State<DelayedTopBottomAnimation>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _animOffset;

  @override
  void initState() {
    super.initState();

    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    final curve = CurvedAnimation(curve: Curves.decelerate, parent: _controller);
    _animOffset =
        Tween<Offset>(begin: const Offset(0.0, -1), end: Offset.zero)
            .animate(curve);

    if (widget.delay == null) {
      _controller.forward();
    } else {
      Timer(Duration(milliseconds: widget.delay), () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _animOffset,
      child: widget.child,
    );
  }
}