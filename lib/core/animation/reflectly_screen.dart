import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';

import 'delayed_animation.dart';
class ReflectlyScreen extends StatefulWidget {
  const ReflectlyScreen({Key? key}) : super(key: key);

  @override
  State<ReflectlyScreen> createState() => ReflectlyScreenState();
}

class ReflectlyScreenState extends State<ReflectlyScreen> with TickerProviderStateMixin{
  final int delayedAmount = 500;
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 200,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    const color = Colors.white;
    _scale = 1 - _controller.value;
    return Scaffold(
        backgroundColor: const Color(0xFF8185E2),
        body: Center(
          child: Column(
            children: <Widget>[
              AvatarGlow(
                endRadius: 90,
                duration: const Duration(seconds: 2),
                glowColor: Colors.white24,
                repeat: true,
                repeatPauseDuration: const Duration(seconds: 2),
                startDelay: const Duration(seconds: 1),
                child: Material(
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      radius: 50.0,
                      child: const FlutterLogo(
                        size: 50.0,
                      ),
                    )),
              ),
              DelayedAnimation(
                delay: delayedAmount + 1000,
                child: const Text(
                  "Hi There",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
              ),
              DelayedAnimation(
                delay: delayedAmount + 2000,
                child: const Text(
                  "I'm Reflectly",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35.0,
                      color: color),
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              DelayedAnimation(
                delay: delayedAmount + 3000,
                child: const Text(
                  "Your New Personal",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
              ),
              DelayedAnimation(
                delay: delayedAmount + 3000,
                child: const Text(
                  "Journaling  companion",
                  style: TextStyle(fontSize: 20.0, color: color),
                ),
              ),
              const SizedBox(
                height: 100.0,
              ),
              DelayedAnimation(
                delay: delayedAmount + 4000,
                child: GestureDetector(
                  onTapDown: _onTapDown,
                  onTapUp: _onTapUp,
                  child: Transform.scale(
                    scale: _scale,
                    child: _animatedButtonUI,
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              DelayedAnimation(
                delay: delayedAmount + 5000,
                child: Text(
                  "I Already have An Account".toUpperCase(),
                  style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: color),
                ),
              ),
            ],
          ),
        )
      //  Column(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   children: <Widget>[
      //     Text('Tap on the Below Button',style: TextStyle(color: Colors.grey[400],fontSize: 20.0),),
      //     SizedBox(
      //       height: 20.0,
      //     ),
      //      Center(

      //   ),
      //   ],

      // ),
    );
  }

  Widget get _animatedButtonUI => Container(
    height: 60,
    width: 270,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100.0),
      color: Colors.white,
    ),
    child: const Center(
      child: Text(
        'Hi Reflectly',
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF8185E2),
        ),
      ),
    ),
  );

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
  }

}
