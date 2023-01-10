import 'dart:async';

import 'package:flutter/material.dart';

import 'top_shape.dart';

class AnimatedShape extends StatefulWidget {
  const AnimatedShape({
    Key? key,
    required this.color,
    required this.show,
    required this.title,
  }) : super(key: key);

  final Color color;
  final bool show;
  final String title;

  @override
  State<AnimatedShape> createState() => _AnimatedShapeState();
}

class _AnimatedShapeState extends State<AnimatedShape>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..addStatusListener((status) {
        debugPrint('animate shape status: $status');
      });

    // '_animationController.forward()' will not work after kill the app if the screen called from main.dart.
    // We need to use setsState() in timer to forward the animation. So it will work it even after kill.
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _animationController.forward();
      });
    });

    debugPrint('animate shape initState');
  }

  @override
  void didUpdateWidget(covariant AnimatedShape oldWidget) {
    super.didUpdateWidget(oldWidget);
    debugPrint('animate shape didUpdateWidget: ${widget.show}');
    if (widget.show) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 480,
      child: /*AnimatedBuilder(
        animation: _animationController,
        builder: (c, child) => Transform.scale(
          scale: _animationController.value,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // color: Colors.blue,
              color: Color(0xffe62f35),
            ),
          ),
        ),
      ),*/
          AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => TopShape.draw(
          widget.color,
          widget.title,
          _animationController,
        ),
      ),
    );
  }

  @override
  void dispose() {
    debugPrint('animate shape dispose');
    _animationController.dispose();
    super.dispose();
  }
}
