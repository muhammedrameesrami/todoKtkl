import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/core/variables.dart';

showSnackBarMessage({
  required String message,
  required BuildContext context,
  Color? color,
}) {
  final snackBar = AnimatedSnackBar(
      animationDuration: const Duration(seconds: 0),
      builder: ((context) {
        return Container(
          height: h * (0.09),
          decoration: BoxDecoration(
              color: color ?? const Color.fromRGBO(64, 23, 117, 1),
              borderRadius: BorderRadius.circular(20)),
          child: Center(
            child: Text(
              message,
              style:
              TextStyle(color: Colors.black, fontSize: h * (0.02)),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );

      }),
      duration: const Duration(seconds: 3),
      desktopSnackBarPosition: DesktopSnackBarPosition.bottomCenter,mobileSnackBarPosition: MobileSnackBarPosition.bottom
  );

  snackBar.show(context);
}