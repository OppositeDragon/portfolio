import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/widgets/window/resizable_draggable_window.dart';

class WindowTitle extends ConsumerWidget {
  const WindowTitle(this.parentKey, {super.key});
  final Key parentKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final window = ref.watch(windowProvider(key!));
    return SizedBox(
      height: 25,
      child: Row(
        children: [
          const SizedBox(width: 10),
          Expanded(
            child: GestureDetector(
                // onPanUpdate: (movement) => widget.onWindowDragged(movement.delta.dx, movement.delta.dy),
                // onPanUpdate: (details) => ref.read(windowControllerProvider.notifier).dragWindow(parentWindow, details.delta),
                child: MouseRegion(cursor: SystemMouseCursors.move, child: Text(window.title))),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              //     onTap: () => ref.read(windowControllerProvider.notifier).minimizeWindow(parentWindow),
              child: Container(
                height: 25,
                width: 32,
                color: Colors.blueGrey.shade100,
                child: const Icon(Icons.minimize_sharp),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => ref.read(windowControllerProvider.notifier).toggleMaximizeWindow(parentKey),
              child: Container(
                height: 25,
                width: 32,
                color: Colors.blueGrey.shade100,
                child: const Icon(
                  Icons.square_outlined,
                  size: 18,
                ),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () => ref.read(windowControllerProvider.notifier).removeWindow(parentKey),
              child: Container(
                height: 25,
                width: 60,
                color: Colors.red,
                child: const Icon(Icons.close_sharp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
