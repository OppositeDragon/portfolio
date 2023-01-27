import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/screens/homepage.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        pageBuilder: (context, state) {
          return CustomTransitionPage(
            key: state.pageKey,
            child: const Homepage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              // Change the opacity of the screen using a Curve based on the the animation's value
              return FadeTransition(
                opacity: CurveTween(curve: Curves.easeInOutCirc).animate(animation),
                child: child,
              );
            },
          );
        },
      ),
    ],
  );
});
