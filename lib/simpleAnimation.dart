import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class RiveAnimationPage extends StatefulWidget {
  const RiveAnimationPage({Key? key}) : super(key: key);

  @override
  State<RiveAnimationPage> createState() => _RiveAnimationPageState();
}

class _RiveAnimationPageState extends State<RiveAnimationPage> {
  late RiveAnimationController _controller;
  late RiveAnimationController _fireUpcontroller;
  late RiveAnimationController _fireDowncontroller;

  late RiveAnimationController _idlecontroller;
  // Toggles between play and pause animation states
  void _togglePlay() async {
    setState(() {
      _idlecontroller.isActive = !_idlecontroller.isActive;
    });
    setState(() => _fireUpcontroller.isActive = true);
    await Future.delayed(const Duration(milliseconds: 500));

    setState(() => _controller.isActive = true);
    setState(() => _fireUpcontroller.isActive = false);

    await Future.delayed(const Duration(seconds: 5));

    setState(() => _controller.isActive = false);

    setState(() => _fireUpcontroller.isActive = false);
    setState(() => _fireDowncontroller.isActive = true);

    await Future.delayed(const Duration(milliseconds: 500));
    setState(() => _idlecontroller.isActive = !_idlecontroller.isActive);
  }

  bool get isPlaying => !_idlecontroller.isActive;

  @override
  void initState() {
    super.initState();

    _idlecontroller = OneShotAnimation('Idle');
    _controller = SimpleAnimation('Takeoff');
    _fireUpcontroller = SimpleAnimation('Fireup');
    _fireDowncontroller = SimpleAnimation('Firedown');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: RiveAnimation.asset(
            'assets/rocket.riv',
            controllers: [
              _controller,
              _fireDowncontroller,
              _fireUpcontroller,
              _idlecontroller
            ],
            onInit: (p0) => setState(() {}),
          ),
        ),
        floatingActionButton:
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          FloatingActionButton(
            heroTag: 'play',
            onPressed: _togglePlay,
            tooltip: isPlaying ? 'Pause' : 'Play',
            child: Icon(
              isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ]));
  }
}
