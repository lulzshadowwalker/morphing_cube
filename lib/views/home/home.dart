import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'dart:math' show pi;

class Home extends HookWidget {
  const Home({super.key});

  static const _colors = [
    Color(0xFF156064),
    Color(0xFF96616B),
    Color(0xFF20063B),
    Color(0xFFE7C8DD),
    Color(0xFFBBBDF6),
    Color(0xFF3A4E48),
  ];

  static const double _sideLen = 150;

  static Stream<int> get _cyclingIndex => Stream.periodic(
        const Duration(seconds: 1),
        (count) => count % _colors.length,
      );

  static final _anim = Tween<double>(begin: 0, end: 2 * pi);

  static const _containerDuration = Duration(seconds: 1);

  @override
  Widget build(BuildContext context) {
    final stream = useMemoized(() => _cyclingIndex);
    final index = useStream(stream).data ?? 0;
    final xCon = useAnimationController(duration: const Duration(seconds: 8))
      ..repeat();
    final yCon = useAnimationController(duration: const Duration(seconds: 16))
      ..repeat();
    final zCon = useAnimationController(duration: const Duration(seconds: 32))
      ..repeat();

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: Listenable.merge([xCon, yCon, zCon]),
          builder: (context, child) => Transform(
            transform: Matrix4.identity()
              ..rotateX(_anim.evaluate(xCon))
              ..rotateY(_anim.evaluate(yCon))
              ..rotateZ(_anim.evaluate(zCon)),
            child: child,
          ),
          child: Stack(
            children: [
              // front
              AnimatedContainer(
                duration: _containerDuration,
                width: _sideLen,
                height: _sideLen,
                color: _colors[index],
              ),

              // back
              Transform(
                transform: Matrix4.identity()..translate(.0, .0, _sideLen),
                child: AnimatedContainer(
                  duration: _containerDuration,
                  width: _sideLen,
                  height: _sideLen,
                  color: _colors[(index + 1) % _colors.length],
                ),
              ),

              // left side
              Transform(
                alignment: Alignment.centerLeft,
                transform: Matrix4.identity()..rotateY(-pi / 2),
                child: AnimatedContainer(
                  duration: _containerDuration,
                  width: _sideLen,
                  height: _sideLen,
                  color: _colors[(index + 2) % _colors.length],
                ),
              ),

              // right side
              Transform(
                alignment: Alignment.centerRight,
                transform: Matrix4.identity()..rotateY(pi / 2),
                child: AnimatedContainer(
                  duration: _containerDuration,
                  width: _sideLen,
                  height: _sideLen,
                  color: _colors[(index + 3) % _colors.length],
                ),
              ),

              // top
              Transform(
                alignment: Alignment.topCenter,
                transform: Matrix4.identity()..rotateX(pi / 2),
                child: AnimatedContainer(
                  duration: _containerDuration,
                  width: _sideLen,
                  height: _sideLen,
                  color: _colors[(index + 4) % _colors.length],
                ),
              ),

              // bottom
              Transform(
                alignment: Alignment.bottomCenter,
                transform: Matrix4.identity()..rotateX(-pi / 2),
                child: AnimatedContainer(
                  duration: _containerDuration,
                  width: _sideLen,
                  height: _sideLen,
                  color: _colors[(index + 5) % _colors.length],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}