import 'dart:math';

import 'package:flutter/material.dart';
import 'package:waterrippleswidget/single_ripple.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watter Ripple Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Watter Ripple Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with TickerProviderStateMixin{
  final double _width = 18.0;
  Animation<double> _animation;
  AnimationController _controller;
  bool _animating = false;
  Offset _center;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(
            duration: const Duration(milliseconds: 1500),
            vsync: this
        );
    _controller.addStatusListener(_onAnimationEnd);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _animating && _center != null
        ? AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => SingleRipple(
              center: _center,
              radius: _animation.value,
              width: _width,
              child: _demoFill(),
          ),
        )
        : GestureDetector(
            child: _demoFill(),
            onTapDown: (TapDownDetails details) => _animationStart(context, details),
        ),
    );
  }

  Widget _demoFill() => Container(
    color: Colors.lightBlue,
    child: ListView(
      children: <Widget>[
        Text(
          'Awesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\nAwesome watter ripple demo app - tap on me!!!\n',
        ),
      ],
    ),
  );

  void _animationStart(BuildContext context, TapDownDetails details) {
    final RenderBox box = context.findRenderObject();
    final Offset localOffset = box.globalToLocal(details.globalPosition);
    final size = box.size;
    final farestX = max(localOffset.dx, size.width - localOffset.dx);
    final farestY = max(localOffset.dy, size.height - localOffset.dy);
    final maxRadius = sqrt(farestX*farestX + farestY*farestY) + _width;
    _animation = Tween<double>(begin: 0, end: maxRadius).animate(_controller);
    setState(() {
      _center = Offset(localOffset.dx, localOffset.dy);
      _animating = true;
    });
    _controller.forward(from: 0.0);
  }

  void _onAnimationEnd(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      setState(() {
        _animating = false;
      });
    }
  }
}
