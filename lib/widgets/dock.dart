import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/dock_controller.dart';
import 'package:portfolio/models/dock_icon.dart';
import 'package:portfolio/widgets/dock_item.dart';

class Dock extends ConsumerWidget {
  const Dock({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<DockIcon> dockIcons = ref.watch(dockControllerProvider);

    // print("asize ${a.length}");
    return Positioned(
      height: 50,
      bottom: 5,
      left: 5,
      right: 5,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            tileMode: TileMode.mirror,
            sigmaX: 6,
            sigmaY: 6,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.65),
                border: Border.all(color: Colors.white60, width: 0.5),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                //const StartMenuIconWidget(),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: dockIcons.map((e) => DockItem(e)).toList(),
                  ),
                ),
                // const SizedBox(
                //   child: Padding(
                //     padding: EdgeInsets.symmetric(horizontal: 8.0),
                //     child: DockDateTime(),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
