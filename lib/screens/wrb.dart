import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class MyWindow extends SingleChildRenderObjectWidget {
  const MyWindow({super.key, required super.child});

  @override
  RenderObject createRenderObject(BuildContext context) {
    return _MyWindowRenderObject();
  }
}

class _MyWindowRenderObject extends RenderBox with RenderObjectWithChildMixin<RenderObject> {
  @override
  bool hitTest(HitTestResult result, {required Offset position}) {
    return true;
  }

  @override
  void performLayout() {
    size = constraints.biggest;
    child?.layout(constraints, parentUsesSize: true);
  }

  late Offset _dragPosition;
  bool _isResizing = false;

  @override
  void handleEvent(PointerEvent event, BoxHitTestEntry entry) {
    if (event is PointerDownEvent) {
      _dragPosition = event.position;
      _isResizing = true;
    } else if (event is PointerMoveEvent) {
      if (_isResizing) {
        size = size + (event.position - _dragPosition);
        _dragPosition = event.position;
        markNeedsPaint();
      }
    } else if (event is PointerUpEvent) {
      _isResizing = false;
    }
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final paint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    context.canvas.drawRect(offset & size, paint);

    const titleBarHeight = 40.0;
    final titleBarPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    context.canvas.drawRect(offset & Size(size.width, titleBarHeight), titleBarPaint);

    final textStyle = const TextStyle(color: Colors.white, fontSize: 20);
    final textSpan = TextSpan(text: 'title', style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr, textAlign: TextAlign.center);
    textPainter.layout();
    textPainter.paint(context.canvas, offset + Offset((size.width - textPainter.width) / 2, 5));

    const iconSize = 15.0;
    const iconPadding = 5.0;
    final iconPosition = Offset(size.width - iconSize - iconPadding, iconPadding);
    final iconPaint = Paint()..color = Colors.yellow;

    context.canvas.drawCircle(iconPosition, iconSize / 2, iconPaint);
    context.canvas.drawCircle(iconPosition + Offset(0, iconSize + iconPadding), iconSize / 2, iconPaint);
  }

  Offset _offset = Offset.zero;

  void updateOffset(Offset newOffset) {
    _offset = newOffset;
    markNeedsPaint();
  }

  bool _isMaximized = false;
  Size _originalSize = Size(100, 100);
  void toggleMaximize() {
    if (_isMaximized) {
      size = _originalSize;
    } else {
      _originalSize = size;
      size = constraints.biggest;
    }
    _isMaximized = !_isMaximized;
    markNeedsPaint();
  }
}
