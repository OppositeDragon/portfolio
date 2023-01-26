import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/models/desktop_icons.dart';
import 'package:portfolio/widgets/window_title.dart';

class ResizableDraggableWindow extends ConsumerWidget {
  ResizableDraggableWindow(this.title, this.body, this.icon, this.orderNumber, {required super.key});
  final String title;
  final Widget body;
  final DesktopIcon icon;
  final int orderNumber;
  double currentHeight = 400;
  double currentWidth = 500;
  double savedHeight = 0;
  double savedWidth = 0;
  double posX = 85;
  double posY = 45;
  WindowState prevWindowState = WindowState.NORMAL;
  WindowState windowState = WindowState.NORMAL;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(windowsProvider);
    return Positioned(
      top: posY,
      left: posX,
      child: Offstage(
        offstage: windowState == WindowState.MINIMIZED ? true : false,
        child: GestureDetector(
          onTap: () => ref.read(windowsProvider).toFront(this),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            color: Colors.amber.withOpacity(0.75),
            child: AnimatedContainer(
              curve: Curves.easeInOutCubic,
              duration: const Duration(milliseconds: 120),
              height: currentHeight,
              width: currentWidth,
              child: Stack(
                children: [
                  Column(
                    children: [
                      WindowTitle(this),
                      Expanded(child: body),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) =>
                          ref.watch(windowsProvider).onHorizontalDragRight(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeLeftRight,
                        opaque: true,
                        child: SizedBox(width: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (details) =>
                          ref.watch(windowsProvider).onHorizontalDragLeft(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeLeftRight,
                        opaque: true,
                        child: SizedBox(width: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) =>
                          ref.watch(windowsProvider).onVerticalDragTop(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpDown,
                        opaque: true,
                        child: SizedBox(height: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onVerticalDragUpdate: (details) =>
                          ref.watch(windowsProvider).onVerticalDragBottom(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpDown,
                        opaque: true,
                        child: SizedBox(height: 4),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) => ref.watch(windowsProvider).onDragTopLeft(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpLeftDownRight,
                        opaque: true,
                        child: SizedBox(height: 6, width: 6),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) => ref.watch(windowsProvider).onDragBottomRight(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpLeftDownRight,
                        opaque: true,
                        child: SizedBox(height: 6, width: 6),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) => ref.watch(windowsProvider).onDragTopRight(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpRightDownLeft,
                        opaque: true,
                        child: SizedBox(height: 6, width: 6),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onPanUpdate: (details) => ref.watch(windowsProvider).onDragBottomLeft(this, details.delta),
                      child: const MouseRegion(
                        cursor: SystemMouseCursors.resizeUpRightDownLeft,
                        opaque: true,
                        child: SizedBox(height: 6, width: 6),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
