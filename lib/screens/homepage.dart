import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/widgets/main_dock.dart';
import 'package:portfolio/widgets/windower.dart';

class Homepage extends ConsumerWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Stack(
        children: const [
          Windower(),
          MainDock(),
        ],
      ),
    );
  }
}
