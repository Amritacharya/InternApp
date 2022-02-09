import 'package:flutter/material.dart';
import 'package:intern_app/animations/painters/logo_painter.dart';

class LogoAnimator extends StatefulWidget {
  const LogoAnimator({Key? key}) : super(key: key);

  @override
  _LogoAnimatorState createState() => _LogoAnimatorState();
}

class _LogoAnimatorState extends State<LogoAnimator>
    with TickerProviderStateMixin {
  double _lineOnefraction = 0.0;
  double _lineTwofraction = 0.0;
  double _blueCirclefraction = 0.0;
  double _greenBarfraction = 0.0;
  double _clipShapeFraction = 0.0;
  late Animation<double> lineOneanimation,
      lineTwoanimation,
      blueCircleAnimation,
      greenBarAnimation,
      clipShapeAnimation;
  late AnimationController controller;

  late AnimationController controllerBounce;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    controllerBounce = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    clipShapeAnimation = Tween(begin: 0.0, end: 1.0).animate(controllerBounce)
      ..addListener(() {
        setState(() {
          _clipShapeFraction = clipShapeAnimation.value;
        });
      });
    lineOneanimation = Tween(begin: 200.0, end: 250.0).animate(controller)
      ..addListener(() {
        setState(() {
          _lineOnefraction = lineOneanimation.value;
        });
      });

    lineTwoanimation = Tween(begin: 300.0, end: 350.0).animate(controller)
      ..addListener(() {
        setState(() {
          _lineTwofraction = lineTwoanimation.value;
        });
      });

    blueCircleAnimation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _blueCirclefraction = blueCircleAnimation.value;
        });
      });
    greenBarAnimation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          _greenBarfraction = greenBarAnimation.value;
        });
      });
    controller.forward();
    controllerBounce.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomPaint(
          painter: LogoPainter(_lineOnefraction, _lineTwofraction,
              _blueCirclefraction, _greenBarfraction, _clipShapeFraction),
        ),
        const SizedBox(
          height: 300,
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.only(top: _clipShapeFraction * 100),
          child: CustomPaint(
            painter: CirclePainter(),
          ),
        )
      ],
    );
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
}
