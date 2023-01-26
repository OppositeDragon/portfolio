import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DockDateTime extends ConsumerStatefulWidget {
  const DockDateTime({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DockDateTimeState();
}

class _DockDateTimeState extends ConsumerState<DockDateTime> with SingleTickerProviderStateMixin {
  late final Timer _timer;
  DateTime b = DateTime.now();
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => setState(() => b = DateTime.now()));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          "${b.hour}:${b.minute}:${b.second}",
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          "${b.day}/${b.month}/${b.year}",
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
