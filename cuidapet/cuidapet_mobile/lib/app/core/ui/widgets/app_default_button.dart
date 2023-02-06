import 'package:flutter/material.dart';

import '../extensions/theme_extension.dart';

class AppDefaultButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final double borderRadius;
  final double labelSize;
  final double padding;
  final double width;
  final double height;
  final Color? color;
  final Color? labelColor;
  final String label;

  const AppDefaultButton({
    required this.onPressed,
    required this.label,
    this.borderRadius = 10,
    this.color,
    this.labelColor,
    this.labelSize = 20,
    this.padding = 10,
    this.width = double.infinity,
    this.height = 66,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color ?? context.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: labelSize,
            color: labelColor ?? Colors.white,
          ),
        ),
      ),
    );
  }
}
