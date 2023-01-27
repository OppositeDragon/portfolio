import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/widgets/desktop.dart';

class Windower extends ConsumerWidget {
  const Windower({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final windowsNotifier = ref.watch(windowsProvider).windows;
    return Stack(
      children: [const Desktop(), ...windowsNotifier],
    );
  }
}
