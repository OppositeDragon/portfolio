import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/models/desktop_icon.dart';
import 'package:portfolio/models/enums.dart';
import 'package:portfolio/widgets/window/title.dart';

class ResizableDraggableWindow extends ConsumerWidget {
  ResizableDraggableWindow({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowController = ref.watch(windowControllerProvider.notifier);
    final window = ref.watch(windowProvider(key! ));
    return Positioned(
      top: window.posY  ,
      left: window.posX,
      child: Offstage(
        offstage: window.windowState == WindowState.MINIMIZED ? true : false,
        child: GestureDetector(
          onTap: () => ref.read(windowControllerProvider.notifier).sendToFront(key!),
          child: Card(
            margin: EdgeInsets.zero,
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            color: Colors.amber.withOpacity(0.75),
            child: AnimatedContainer(
              curve: Curves.easeInOutCubic,
              duration: const Duration(milliseconds: 120),
              height: window.currentHeight,
              width: window.currentWidth,
              child: Stack(
                children: [
                  Column(
                    children: [
                      WindowTitle(key!),
                      Expanded(child: window.body),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: GestureDetector(
                     // onHorizontalDragUpdate: (details) => windowController.onHorizontalDragRight(key!, details.delta),
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
                   //   onHorizontalDragUpdate: (details) => windowController.onHorizontalDragLeft(this, details.delta),
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
                    //  onVerticalDragUpdate: (details) => windowController.onVerticalDragTop(this, details.delta),
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
                    //  onVerticalDragUpdate: (details) => windowController.onVerticalDragBottom(this, details.delta),
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
                   //   onPanUpdate: (details) => windowController.onDragTopLeft(this, details.delta),
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
                    //  onPanUpdate: (details) => windowController.onDragBottomRight(this, details.delta),
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
                    //  onPanUpdate: (details) => windowController.onDragTopRight(this, details.delta),
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
                    //  onPanUpdate: (details) => windowController.onDragBottomLeft(this, details.delta),
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
