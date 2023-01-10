import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TopShape extends CustomClipper<Path> {
  final AnimationController controller;

  TopShape._(this.controller);

  static Widget draw(
    Color color,
    String text,
    AnimationController controller,
  ) {
    return ClipPath(
      clipper: TopShape._(controller),
      child: ColoredBox(
        color: color,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, top: 16),
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Path getClip(Size size) {
    debugPrint('width: ${size.width}');
    debugPrint('height: ${size.height}');

    /*debugPrint('Value of x1: ${335 / 390}');
    debugPrint('Value of y1: ${99.66 / 209}');
    debugPrint('Value of x2: ${371 / 390}');
    debugPrint('Value of y2: ${70.67 / 209}');
    debugPrint('Value of x3: ${381 / 390}');
    debugPrint('Value of y3: ${56.17 / 209}');*/

    final path = Path();

    //First Point
    path.lineTo(
        0,
        Tween<double>(begin: 0, end: size.height * 0.4795502882344498)
            .animate(controller)
            .value);

    //Second Point
    path.cubicTo(
      size.width * 0.18974358974358974,
      Tween<double>(begin: 0, end: size.height * 0.40746411483253586)
          .animate(controller)
          .value,
      size.width * 0.23846153846153847,
      Tween<double>(begin: 0, end: size.height * 0.303444976076555)
          .animate(controller)
          .value,
      size.width * 0.2846153846153846,
      Tween<double>(begin: 0, end: size.height * 0.303444976076555)
          .animate(controller)
          .value,
    );

    //Third Point
    path.cubicTo(
      size.width * 0.3333333333333333,
      Tween<double>(begin: 0, end: size.height * 0.303444976076555)
          .animate(controller)
          .value,
      size.width * 0.382051282051282,
      Tween<double>(begin: 0, end: size.height * 0.40746411483253586)
          .animate(controller)
          .value,
      size.width * 0.4282051282051282,
      Tween<double>(begin: 0, end: size.height * 0.4594736842105263)
          .animate(controller)
          .value,
    );

    //Forth Point
    path.cubicTo(
      size.width * 0.47692307692307695,
      Tween<double>(begin: 0, end: size.height * 0.5028229665071771)
          .animate(controller)
          .value,
      size.width * 0.5230769230769231,
      Tween<double>(begin: 0, end: size.height * 0.5028229665071771)
          .animate(controller)
          .value,
      size.width * 0.5717948717948718,
      Tween<double>(begin: 0, end: size.height * 0.4768421052631579)
          .animate(controller)
          .value,
    );

    //Fifth Point
    path.cubicTo(
      size.width * 0.617948717948718,
      Tween<double>(begin: 0, end: size.height * 0.44215311004784685)
          .animate(controller)
          .value,
      size.width * 0.6666666666666666,
      Tween<double>(begin: 0, end: size.height * 0.37277511961722487)
          .animate(controller)
          .value,
      size.width * 0.7153846153846154,
      Tween<double>(begin: 0, end: size.height * 0.3901435406698565)
          .animate(controller)
          .value,
    );

    //Sixth Point
    path.cubicTo(
      size.width * 0.7615384615384615,
      Tween<double>(begin: 0, end: size.height * 0.40746411483253586)
          .animate(controller)
          .value,
      size.width * 0.8102564102564103,
      Tween<double>(begin: 0, end: size.height * 0.5028229665071771)
          .animate(controller)
          .value,
      size.width * 0.8564102564102564,
      Tween<double>(begin: 0, end: size.height * 0.4941626794258373)
          .animate(controller)
          .value,
    );

    //Seventh Point
    path.cubicTo(
      size.width * 0.9311282051282051,
      Tween<double>(begin: 0, end: size.height * 0.4768421052631579)
          .animate(controller)
          .value,
      size.width * 0.9462820512820512,
      Tween<double>(begin: 0, end: size.height * 0.33813397129186606)
          .animate(controller)
          .value,
      size.width * 0.9809230769230769,
      Tween<double>(begin: 0, end: size.height * 0.268755980861244)
          .animate(controller)
          .value,
    );

    //Last Point
    path.lineTo(size.width * 1.12787, 0);

    //Close path
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
