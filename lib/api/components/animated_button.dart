import 'package:flutter/material.dart';

class AnimatedButton extends StatefulWidget {
  const AnimatedButton({
    Key? key,
    required this.onTap,
    required this.color,
    required this.text,
  }) : super(key: key);

  final VoidCallback? onTap;
  final Color color;
  final String text;

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animation =
        Tween<double>(begin: 1.0, end: 0.9).animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: widget.onTap != null
          ? (_) {
              _animationController.forward();
            }
          : null,
      onTapUp: widget.onTap != null
          ? (_) {
              _animationController.reverse();
            }
          : null,
      onTapCancel: widget.onTap != null
          ? () {
              _animationController.reverse();
            }
          : null,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) {
          return Transform.scale(
            scale: _animation.value,
            child: Container(
              padding: const EdgeInsets.symmetric(
                vertical: 18,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: widget.color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
