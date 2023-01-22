import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/models/window_properties.dart';
import 'package:portfolio/widgets/desktop.dart';
import 'package:portfolio/widgets/window/resizable_draggable_window.dart';

class Windower extends ConsumerWidget {
  const Windower({super.key});
  // final List<ResizableDraggableWindow> windowsProvider = [];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<WindowProperties> windows = ref.watch(windowControllerProvider);
    ref.listen(
      windowControllerProvider,
      (previous, next) {
        print('state same? ${previous == next}');
      },
    );
    return Stack(
      children: [const Desktop(), for (final prop in windows)
			 ResizableDraggableWindow(key: prop.key)],
    );
  }
}
