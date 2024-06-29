import 'package:flutter/material.dart';
import 'package:leaf_healer/constants/constants.dart';

class CardWidget extends StatelessWidget {
  final BorderSide border;
  final Color backgroundColor;
  final BoxShadow? boxShadow;
  final Widget child;
  final bool showShadow;
  final BorderRadiusGeometry? borderRadius;
  const CardWidget({
    super.key,
    this.border = BorderSide.none,
    this.backgroundColor = AppColors.lightNeutralTextColor,
    required this.child,
    this.showShadow = true,
    this.boxShadow,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: showShadow
              ? [
                  boxShadow ??
                      BoxShadow(
                        color: AppColors.lighter3DarkColor.withOpacity(0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                        spreadRadius: 0,
                      ),
                ]
              : null),
      margin: EdgeInsets.zero,
      child: Material(
        shape: RoundedRectangleBorder(
            side: border,
            borderRadius:
                borderRadius ?? const BorderRadius.all(Radius.circular(12))),
        type: MaterialType.card,
        color: backgroundColor,
        child: child,
      ),
    );
  }
}
