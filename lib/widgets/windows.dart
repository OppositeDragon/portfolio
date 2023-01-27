import 'package:flutter/material.dart';
import 'package:portfolio/widgets/desktop.dart';

class Windows extends StatelessWidget {
  const Windows({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Widget> desktopWindows = [const Desktop()];
    return Stack(children: desktopWindows);
  }
}
