import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/router.dart';

void main() {
  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'OppositeDragon\'s Portfolio ',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      routerConfig: ref.watch(routerProvider),
    );
  }
}
