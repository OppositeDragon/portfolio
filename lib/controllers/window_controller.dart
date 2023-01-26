import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/desktop_icons.dart';
import 'package:portfolio/widgets/resizable_draggable_window.dart';

final windowsProvider = ChangeNotifierProvider((ref) => WindowsController());

enum WindowState { MAXIMIZED, MINIMIZED, NORMAL }

class WindowsController with ChangeNotifier {
  final List<ResizableDraggableWindow> _windows = [];
  late Offset _windowPosition = Offset.zero;
  int orderNumber = 0;
  void createNewWindow(String title, Widget body, DesktopIcon icon) {
    ResizableDraggableWindow resizableDraggableWindow = ResizableDraggableWindow(
      title,
      body,
      icon,
      orderNumber,
      key: UniqueKey(),
    );
    _windows.add(resizableDraggableWindow);
    orderNumber++;
    notifyListeners();
  }

  void toFront(ResizableDraggableWindow resizableDraggableWindow) {
    _windows.remove(resizableDraggableWindow);
    _windows.add(resizableDraggableWindow);
    notifyListeners();
  }

  void removeWindow(ResizableDraggableWindow resizableDraggableWindow) {
    _windows.remove(resizableDraggableWindow);
    notifyListeners();
  }

  void dragWindow(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    if (resizableDraggableWindow.windowState == WindowState.MAXIMIZED) {
      maximizeWindow(resizableDraggableWindow);
    }
    resizableDraggableWindow.posX += delta.dx;
    resizableDraggableWindow.posY += delta.dy;
    _windowPosition = Offset(resizableDraggableWindow.posX, resizableDraggableWindow.posY);
    notifyListeners();
  }

  void maximizeWindow(ResizableDraggableWindow resizableDraggableWindow) {
    if (resizableDraggableWindow.windowState == WindowState.MAXIMIZED) {
      resizableDraggableWindow.currentHeight = resizableDraggableWindow.savedHeight;
      resizableDraggableWindow.currentWidth = resizableDraggableWindow.savedWidth;
      resizableDraggableWindow.prevWindowState = WindowState.NORMAL;
      resizableDraggableWindow.windowState = WindowState.NORMAL;
      dragWindow(resizableDraggableWindow, const Offset(100, 100));
    } else {
      Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
      dragWindow(resizableDraggableWindow, Offset(-resizableDraggableWindow.posX, -resizableDraggableWindow.posY));
      resizableDraggableWindow.savedHeight = resizableDraggableWindow.currentHeight;
      resizableDraggableWindow.savedWidth = resizableDraggableWindow.currentWidth;
      resizableDraggableWindow.currentHeight = size.height - 57;
      resizableDraggableWindow.currentWidth = size.width;
      resizableDraggableWindow.prevWindowState = WindowState.MAXIMIZED;
      resizableDraggableWindow.windowState = WindowState.MAXIMIZED;
    }
    notifyListeners();
  }

  void minimizeWindow(ResizableDraggableWindow resizableDraggableWindow) {
    if (resizableDraggableWindow.windowState == WindowState.MINIMIZED) {
      unminimizeWindow(resizableDraggableWindow);
    } else {
      resizableDraggableWindow.windowState = WindowState.MINIMIZED;
      notifyListeners();
    }
  }

  void unminimizeWindow(ResizableDraggableWindow resizableDraggableWindow) {
    toFront(resizableDraggableWindow);
    resizableDraggableWindow.windowState = resizableDraggableWindow.prevWindowState;
    notifyListeners();
  }

  void onHorizontalDragRight(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    resizableDraggableWindow.currentWidth += delta.dx;
    if (resizableDraggableWindow.currentWidth <= 250) {
      resizableDraggableWindow.currentWidth = 250;
    } else {
      notifyListeners();
    }
  }

  void onVerticalDragBottom(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    resizableDraggableWindow.currentHeight += delta.dy;
    if (resizableDraggableWindow.currentHeight <= 250) {
      resizableDraggableWindow.currentHeight = 250;
    } else {
      notifyListeners();
    }
  }

  void onHorizontalDragLeft(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    resizableDraggableWindow.currentWidth -= delta.dx;
    if (resizableDraggableWindow.currentWidth > 250) {
      dragWindow(resizableDraggableWindow, delta);
    } else {
      resizableDraggableWindow.currentWidth = 250;
    }
  }

  void onVerticalDragTop(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    resizableDraggableWindow.currentHeight -= delta.dy;
    if (resizableDraggableWindow.currentHeight > 250) {
      dragWindow(resizableDraggableWindow, delta);
    } else {
      resizableDraggableWindow.currentHeight = 250;
    }
  }

  void onDragTopLeft(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    onHorizontalDragLeft(resizableDraggableWindow, Offset(delta.dx, 0));
    onVerticalDragTop(resizableDraggableWindow, Offset(0, delta.dy));
  }

  void onDragBottomRight(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    onHorizontalDragRight(resizableDraggableWindow, Offset(delta.dx, 0));
    onVerticalDragBottom(resizableDraggableWindow, Offset(0, delta.dy));
  }

  void onDragTopRight(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    onHorizontalDragRight(resizableDraggableWindow, Offset(delta.dx, 0));
    onVerticalDragTop(resizableDraggableWindow, Offset(0, delta.dy));
  }

  void onDragBottomLeft(ResizableDraggableWindow resizableDraggableWindow, Offset delta) {
    onHorizontalDragLeft(resizableDraggableWindow, Offset(delta.dx, 0));
    onVerticalDragBottom(resizableDraggableWindow, Offset(0, delta.dy));
  }

  List<ResizableDraggableWindow> get windows {
    return _windows;
  }

  Offset get windowPosition => _windowPosition;
}
