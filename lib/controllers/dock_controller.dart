import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/dock_icon.dart';

final dockControllerProvider = StateNotifierProvider<DockController, List<DockIcon>>((ref) {
  final List<DockIcon> state = [];
  return DockController(state);
});

class DockController extends StateNotifier<List<DockIcon>> {
  DockController(super.state);
}
