import 'dart:math';

import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late double radius = 50;
  late final Animation<double> _animation;
  late AnimationController _controller;
  late Animation<double> animation_rotation;
  late Animation<double> animation_radius_in;
  late Animation<double> animation_radius_out;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.green,
      //   title: Text("Loading"),
      //   centerTitle: true,
      // ),
      body: Center(
        child: Container(
          height: size.height*0.1,
          width: size.width*0.1,
          child: Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.lineSpinFadeLoader,
                  colors: const [Colors.green],
                 )
              ),
        ),
      ),
    );
  }
}

class RectangleBar extends StatelessWidget {
  final double myHeight;
  final double myWidth;
  const RectangleBar({Key? key, required this.myHeight, required this.myWidth})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: this.myHeight,
        width: this.myWidth,
        color: Colors.green,
      ),
    );
  }
}

class CenterCircle extends StatelessWidget {
  final double radius;
  final Color myColor;
  const CenterCircle({
    Key? key,
    required this.radius,
    required this.myColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: this.radius,
        height: this.radius,
        decoration: BoxDecoration(color: this.myColor, shape: BoxShape.circle),
      ),
    );
  }
}
