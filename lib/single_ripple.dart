import 'package:flutter/cupertino.dart';
import 'package:waterrippleswidget/circle_clip.dart';

class SingleRipple extends StatelessWidget {
  final Offset center;
  final double width;
  final double radius;
  final Widget child;

  const SingleRipple({
    Key key,
    @required this.radius,
    @required this.child,
    @required this.center,
    this.width = 18,
  }) :  assert(radius != null),
        assert(child != null),
        assert(center != null),
        assert(width >= 10),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final layerNum = (width / 2).ceil();
    final internalRadius = radius - width;
    final RenderBox box = context.findRenderObject();
    final localOffset = box != null ? box.globalToLocal(center) : null;
    return localOffset != null
        ? Stack(
        children: <Widget>[
          child,
          for(int i in Iterable<int>.generate(layerNum))
            _getLayer(i, layerNum, child, localOffset),
          ClipPath(
            clipper: CircleClip(
              center: localOffset,
              radius: internalRadius,
            ),
            child: child,
            clipBehavior: Clip.hardEdge,
          ),
        ],
      )
        : child;
  }

  Widget _getLayer(int i, int layerNum, Widget child, Offset center) {
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