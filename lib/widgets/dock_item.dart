

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/models/dock_icon.dart';
import 'package:portfolio/widgets/window/resizable_draggable_window.dart';

class DockItem extends ConsumerStatefulWidget {
  const DockItem(this.dockIcon, {Key? key}) : super(key: key);
  final DockIcon dockIcon;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DockItemState();
}

class _DockItemState extends ConsumerState<DockItem> {
  bool onOverlay = false;
  OverlayEntry? entry;
  late List<ResizableDraggableWindow> windows;
  @override
  void initState() {
    super.initState();
   // windows = ref.read(windowControllerProvider);
  }

  void showOverlay() {
    final overlay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width + 30,
        bottom: 57,
        left: (offset.dx - 15),
        child: MouseRegion(
          onEnter: (_) => onOverlay = true,
          onExit: (_) {
            onOverlay = false;
            if (!onOverlay && entry != null) {
              removeOverlay();
            }
          },
          child: Material(
            elevation: 16,
            borderRadius: BorderRadius.circular(5),
            clipBehavior: Clip.antiAlias,
            color: Colors.black.withOpacity(0.75),
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: Column(
                children: [
                  for (final key in widget.dockIcon.windowKeys)
                    GestureDetector(
                      onTap: () {
                        final window = windows.firstWhere((window) => window.key == key);
                       // ref.read(windowControllerProvider.notifier).unminimizeWindow(window);
                        onOverlay = false;
                        if (!onOverlay && entry != null) {
                          removeOverlay();
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 6.0),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: Colors.white70),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          key.toString() + " " + widget.dockIcon.icon.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w200),
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
    overlay!.insert(entry!);
  }

  void removeOverlay() {
    entry!.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    int numDots = widget.dockIcon.windowKeys.length >= 3 ? 3 : widget.dockIcon.windowKeys.length;

    return MouseRegion(
      onEnter: (event) {
        ///onOverlay = true;
        if (entry == null) {
          showOverlay();
        }
      },
      onExit: (_) async {
        // onOverlay = false;
        await Future.delayed(const Duration(milliseconds: 150), () {
          if (!onOverlay && entry != null) {
            removeOverlay();
          }
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 2),
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            constraints: const BoxConstraints(maxHeight: 33, minHeight: 33, maxWidth: 100, minWidth: 30),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.white30, width: 0.4), color: Colors.black26, borderRadius: BorderRadius.circular(5)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  widget.dockIcon.icon.iconPath,
                  fit: BoxFit.contain,
                  width: 30,
                  height: 30,
                ),
                Flexible(
                  child: Text(
                    widget.dockIcon.icon.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 8,
                    ),
                  ),
                )
              ],
            ),
          ),
          ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 7, minHeight: 7, maxWidth: 100, minWidth: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < numDots; i++)
                  const DecoratedBox(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          Colors.white,
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: SizedBox(width: 8, height: 8),
                  )
              ],
            ),
          )
        ],
      ),
    );
  }
}
