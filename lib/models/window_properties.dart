import 'package:flutter/material.dart';
import 'package:portfolio/models/desktop_icon.dart';
import 'package:portfolio/models/enums.dart';

@immutable
class WindowProperties {
  final Key key;
  final String title;
  final Widget body;
  final DesktopIcon icon;
  final int orderNumber;
  final double currentHeight;
  final double currentWidth;
  final double savedHeight;
  final double savedWidth;
  final double posX;
  final double posY;
  final WindowState prevWindowState;
  final WindowState windowState;

  const WindowProperties({
    required this.key,
    required this.title,
    required this.body,
    required this.icon,
    required this.orderNumber,
    this.currentHeight = 400,
    this.currentWidth = 500,
    this.savedHeight = 0,
    this.savedWidth = 0,
    this.posX = 85,
    this.posY = 45,
    this.prevWindowState = WindowState.NORMAL,
    this.windowState = WindowState.NORMAL,
  });

  WindowProperties copyWith({
    String? title,
    Widget? body,
    DesktopIcon? icon,
    int? orderNumber,
    double? currentHeight,
    double? currentWidth,
    double? savedHeight,
    double? savedWidth,
    double? posX,
    double? posY,
    WindowState? prevWindowState,
    WindowState? windowState,
  }) {
    return WindowProperties(
			key: key,
      title: title ?? this.title,
      body: body ?? this.body,
      icon: icon ?? this.icon,
      orderNumber: orderNumber ?? this.orderNumber,
      currentHeight: currentHeight ?? this.currentHeight,
      currentWidth: currentWidth ?? this.currentWidth,
      savedHeight: savedHeight ?? this.savedHeight,
      savedWidth: savedWidth ?? this.savedWidth,
      posX: posX ?? this.posX,
      posY: posY ?? this.posY,
      prevWindowState: prevWindowState ?? this.prevWindowState,
      windowState: windowState ?? this.windowState,
    );
  }

  @override
  bool operator ==(covariant WindowProperties other) {
    if (identical(this, other)) return true;

    return other.title == title &&
        other.body == body &&
        other.icon == icon &&
        other.orderNumber == orderNumber &&
        other.currentHeight == currentHeight &&
        other.currentWidth == currentWidth &&
        other.savedHeight == savedHeight &&
        other.savedWidth == savedWidth &&
        other.posX == posX &&
        other.posY == posY &&
        other.prevWindowState == prevWindowState &&
        other.windowState == windowState;
  }

  @override
  int get hashCode {
    return title.hashCode ^
        body.hashCode ^
        icon.hashCode ^
        orderNumber.hashCode ^
        currentHeight.hashCode ^
        currentWidth.hashCode ^
        savedHeight.hashCode ^
        savedWidth.hashCode ^
        posX.hashCode ^
        posY.hashCode ^
        prevWindowState.hashCode ^
        windowState.hashCode;
  }
}
