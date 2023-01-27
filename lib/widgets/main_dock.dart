import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/dock_controller.dart';
import 'package:portfolio/models/dock_icons.dart';
import 'package:portfolio/widgets/date_time_dock.dart';
import 'package:portfolio/widgets/dock_item.dart';

class MainDock extends ConsumerStatefulWidget {
  const MainDock({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainDockState();
}

class _MainDockState extends ConsumerState<MainDock> {
  @override
  Widget build(BuildContext context) {
    final List<DockIcon> dockIcons = ref.watch(dockProvider).getDockIcons();
    return Positioned(
      bottom: 5,
      left: 5,
      right: 5,
      child: SizedBox(
        height: 50,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 7,
              sigmaY: 7,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.75),
                  border: Border.all(color: Colors.white60, width: 0.5),
                  borderRadius: BorderRadius.circular(5)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 5),
                  const Card(
                    color: Colors.blue,
                    child: SizedBox(width: 30, height: 30),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: dockIcons.map((e) => DockItem(e)).toList(),
                    ),
                  ),
                  const SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: DockDateTime(),
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
