import 'dart:math';

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class Window extends SingleChildRenderObjectWidget {
  const Window({super.key, required super.child});
  @override
  RenderObject createRenderObject(BuildContext context) {
    return RenderWindow();
  }
}

class WindowParentData extends ContainerBoxParentData<RenderBox> {}

class RenderWindow extends RenderBox with RenderObjectWithChildMixin<RenderBox> {
  @override
  void paint(PaintingContext context, Offset offset) {
    final canvas = context.canvas;
    final paint = Paint()..color = Color.fromRGBO(28, 31, 34, 0.95);
    canvas.save();
    //canvas.rotate(pi / 180 * 15);
    canvas.drawRRect(
        RRect.fromRectAndCorners(offset & size,
            bottomLeft: const Radius.circular(8),
            bottomRight: const Radius.circular(8),
            topLeft: const Radius.circular(8),
            topRight: const Radius.circular(8)),
        paint);
//canvas.restore();
    child?.paint(context, offset + const Offset(6, 26));
  }

  @override
  bool paintsChild(covariant RenderObject child) {
    return true;
  }

  Size _performLayout() {
    return Size(300, 400);
  }

  @override
  void performLayout() {
    size = _performLayout();
    size = constraints.biggest;
    // layout(BoxConstraints(maxWidth: 300, maxHeight: 400, minHeight: constraints.minHeight,minWidth: constraints.minWidth), parentUsesSize: false);
    child?.layout(
      BoxConstraints(
        maxWidth: size.width - 12,
        maxHeight: size.height - 32,
      ),
      parentUsesSize: true,
    );
  }

  @override
  Size computeDryLayout(BoxConstraints constraints) {
    return _performLayout();
  }

  @override
  void setupParentData(covariant RenderObject child) {
    if (child.parentData is! WindowParentData) {
      child.parentData = WindowParentData();
    }
  }

  @override
  double computeMaxIntrinsicHeight(double width) {
    return size.width;
  }

  @override
  double computeMinIntrinsicHeight(double width) {
    return size.width;
  }

  @override
  double computeMaxIntrinsicWidth(double height) {
    return size.width;
  }

  @override
  double computeMinIntrinsicWidth(double height) {
    return size.width;
  }
}
