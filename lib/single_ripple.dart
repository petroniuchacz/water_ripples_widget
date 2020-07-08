import 'package:flutter/cupertino.dart';
import 'package:waterrippleswidget/circle_clip.dart';

class SingleRipple extends StatelessWidget {
  final Offset center;
  final double width;
  final double radius;
  final Widget child;

  const SingleRipple({
    Key key,
    this.width,
    this.radius,
    this.child,
    this.center
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final layerNum = 15;
    final internalRadius = radius - width;
    return Stack(
      children: <Widget>[
        child,
        for(int i in Iterable<int>.generate(layerNum))
          _getLayer(i, layerNum, child),
        ClipPath(
          clipper: CircleClip(
            center: center,
            radius: internalRadius,
          ),
          child: child,
          clipBehavior: Clip.hardEdge,
        ),
      ],
    );
  }

  Widget _getLayer(int i, int layerNum, Widget child) {
    final currentRadius = radius - i/layerNum * width;
    final alphaCoef = 0.15;
    final scaleCoef = 0.006 * radius / 100;
    return ClipPath(
      clipper: CircleClip(
        center: center,
        radius: currentRadius,
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
          children: [
            Transform.scale(
              scale: i <= layerNum/2
                  ? 1 + scaleCoef - scaleCoef * i/layerNum * 2
                  : 1 - scaleCoef + scaleCoef * (i/layerNum - 0.5) *2,
              child: child,
              origin: center,
            ),
            Positioned.fill(
              child: Container(
                color: i <= layerNum/2
                    ? Color.fromRGBO(255, 255, 255, alphaCoef * (0.0 + i/layerNum * 2))
                    : Color.fromRGBO(0, 0, 0, alphaCoef * (-1.0 + i/layerNum * 2)),
              ),
            ),
          ]
      ),
    );
  }
}