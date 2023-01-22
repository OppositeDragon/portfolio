import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/models/desktop_icon.dart';
import 'package:portfolio/models/enums.dart';
import 'package:portfolio/models/window_properties.dart';
import 'package:portfolio/widgets/window/resizable_draggable_window.dart';

final windowProvider = Provider.family<WindowProperties, Key>((ref, key) {
  final windowProps = ref.watch(windowControllerProvider);
  return windowProps.firstWhere((element) => element.key == key);
});

final windowControllerProvider = StateNotifierProvider<WindowController, List<WindowProperties>>((ref) {
  final List<WindowProperties> state = [];
  return WindowController(state);
});

class WindowController extends StateNotifier<List<WindowProperties>> {
  WindowController(super.state);
  Offset _windowPosition = Offset.zero;
  int orderNumber = 0;
  void createWindow(String title, Widget body, DesktopIcon icon) {
    state = [
      ...state,
      WindowProperties(
        title: title,
        body: body,
        icon: icon,
        orderNumber: orderNumber,
        key: UniqueKey(),
      ),
    ];
    orderNumber++;
  }

  void sendToFront(Key key) {
    state = [
      for (final window in state)
        if (window.key != key) window,
      state.firstWhere((element) => element.key == key),
    ];
  }

  void removeWindow(Key key) {
    state = [
      for (final window in state)
        if (window.key != key) window,
    ];
  }

  void toggleMaximizeWindow(Key key) {
    WindowProperties window = state.firstWhere((element) => element.key == key);
    if (window.windowState == WindowState.MAXIMIZED) {
      window = window.copyWith(
          currentHeight: window.savedHeight,
          currentWidth: window.savedWidth,
          prevWindowState: WindowState.NORMAL,
          windowState: WindowState.NORMAL,
          posX: 100,
          posY: 100);
    } else {
      Size size = MediaQueryData.fromWindow(WidgetsBinding.instance.window).size;
      window.copyWith(
          posX: 0,
          posY: 0,
          savedHeight: window.currentHeight,
          savedWidth: window.currentWidth,
          currentHeight: size.height - 57,
          currentWidth: size.width,
          prevWindowState: WindowState.MAXIMIZED,
          windowState: WindowState.MAXIMIZED);
    }
    state = [
      for (final windowProp in state)
        if (windowProp.key == key) window else windowProp,
    ];
  }

  // void applyChangesToWindow(Key key) {
  //   debugPrint('state: $state');
  //   state = [
  //     for (final window in state)
  //       if (window == key) key else window,
  //   ];
  //   debugPrint('state: $state');
  // }

// //TODO: fix circular calls from dragWindow to toggleMaximizeWindow
//   void dragWindow(Key key, Offset delta) {
//     debugPrint('dragWindow(x:${window.posX} y:${window.posY}, $delta))');
//     if (key.windowState == WindowState.MAXIMIZED) {
//       toggleMaximizeWindow(key);
//     }
//     key.copyWith(
//       posX: key.posX + delta.dx,
//       posY: key.posY + delta.dy,
//     );
//     _windowPosition = Offset(key.posX, key.posY);
//     applyChangesToWindow(key);
//   }

//   void unminimizeWindow(Key key) {
//     sendToFront(key);
//     key.copyWith(windowState: key.prevWindowState);
//     applyChangesToWindow(key);
//   }

//   void minimizeWindow(Key key) {
//     if (key.windowState == WindowState.MINIMIZED) {
//       unminimizeWindow(key);
//     } else {
//       key.copyWith(windowState: WindowState.MINIMIZED);
//       applyChangesToWindow(key);
//     }
//   }

//
//   void onHorizontalDragRight(Key key, Offset delta) {
//     // if (key.currentWidth == 250) {
//     //   return;
//     // }
//     key.copyWith(currentWidth: key.currentWidth + delta.dx);

//     if (key.currentWidth < 250) {
//       key.copyWith(currentWidth: 250);
//     }
//     applyChangesToWindow(key);
//   }

//   void onVerticalDragBottom(Key key, Offset delta) {
//     // if (key.currentHeight == 250) {
//     //   return;
//     // }

//     double height = key.currentHeight + delta.dy;
//     if (height < 250) {
//       height = 250;
//     }
//     key.copyWith(currentHeight: height);
//     applyChangesToWindow(key);
//   }

//   void onHorizontalDragLeft(Key key, Offset delta) {
//     double width = key.currentWidth - delta.dx;
//     if (width > 250) {
//       dragWindow(key, delta);
//     } else {
//       key.copyWith(currentWidth: 250);
//       applyChangesToWindow(key);
//     }
//   }

//   void onVerticalDragTop(Key key, Offset delta) {
//     double height = key.currentHeight - delta.dy;
//     if (height > 250) {
//       dragWindow(key, delta);
//     } else {
//       key.copyWith(currentHeight: 250);
//       applyChangesToWindow(key);
//     }
//   }

//   void onDragTopLeft(Key key, Offset delta) {
//     onHorizontalDragLeft(key, Offset(delta.dx, 0));
//     onVerticalDragTop(key, Offset(0, delta.dy));
//   }

//   void onDragBottomRight(Key key, Offset delta) {
//     onHorizontalDragRight(key, Offset(delta.dx, 0));
//     onVerticalDragBottom(key, Offset(0, delta.dy));
//   }

//   void onDragTopRight(Key key, Offset delta) {
//     onHorizontalDragRight(key, Offset(delta.dx, 0));
//     onVerticalDragTop(key, Offset(0, delta.dy));
//   }

//   void onDragBottomLeft(Key key, Offset delta) {
//     onHorizontalDragLeft(key, Offset(delta.dx, 0));
//     onVerticalDragBottom(key, Offset(0, delta.dy));
//   }
}
