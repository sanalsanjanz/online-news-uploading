// ignore_for_file: prefer_const_constructors, file_names

import 'package:flutter/material.dart';

class PageAnimations extends PageRouteBuilder {
  final Widget widget;
  PageAnimations({required this.widget})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> scondAnimation) {
            return widget;
          },
          transitionDuration: Duration(milliseconds: 100),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondAnimation,
              Widget child) {
            animation = CurvedAnimation(
                parent: animation, curve: Curves.fastLinearToSlowEaseIn);
            return ScaleTransition(
              scale: animation,
              child: child,
              alignment: Alignment.center,
            );
          },
        );
}
