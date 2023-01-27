import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/controllers/window_controller.dart';
import 'package:portfolio/models/dock_icons.dart';
import 'package:portfolio/widgets/resizable_draggable_window.dart';

final dockProvider = ChangeNotifierProvider((ref) {
  final windows = ref.watch(windowsProvider).windows;
  return DockController(windows);
});

class DockController with ChangeNotifier {
  DockController(this._listOfOpenWindows);
  final List<ResizableDraggableWindow> _listOfOpenWindows;
  final List<DockIcon> _dockIcons = [];
  final List<Key> _windowsKeys = [];
  List<DockIcon> getDockIcons() {
    _dockIcons.clear();
    for (var openWindow in _listOfOpenWindows) {
      //agregar DockIcon a _dockIcons, solo si todavia no ha sido agregado
      if (!_dockIcons.any((element) => element.icon.fileType == openWindow.icon.fileType)) {
        // Iterar sobre la lista de ventanas abiertas, y agregar a la lista de llaves,
        // unicamente de las ventanas que coinciden con el tipo de archivo.
        for (var oW in _listOfOpenWindows) {
          if (oW.icon.fileType == openWindow.icon.fileType) {
            _windowsKeys.add(oW.key!);
          }
        }
        _dockIcons.add(DockIcon(openWindow.icon, [..._windowsKeys]));
      }
      _windowsKeys.clear();
    }
    _dockIcons.sort((a, b) => a.icon.name.compareTo(b.icon.name));
    return _dockIcons;
  }

  List<DockIcon> get dockIcons => _dockIcons;
}
