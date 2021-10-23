import 'package:flutter/material.dart';

class BorderIcon extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double width, height;

  const BorderIcon(
      {Key key, @required this.child, this.padding, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          // color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.circular(0),
        ),
        padding: padding ?? const EdgeInsets.all(8.0),
        child: Center(child: child));
  }
}
