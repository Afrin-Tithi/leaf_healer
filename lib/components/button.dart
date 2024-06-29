import 'package:flutter/material.dart';

class PButton extends StatelessWidget {
  final ValueGetter? onTap;
  final String? label;
  final bool? disabled;
  final Widget? child;

  const PButton({
    super.key,
    this.onTap,
    this.label,
    this.disabled,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        if (disabled != null && disabled!) {
          return;
        }
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            gradient: LinearGradient(
              colors: [
                const Color.fromARGB(203, 1, 27, 42)
                    .withOpacity(disabled != null && disabled! ? 0.4 : 1),
                const Color.fromARGB(255, 1, 28, 3)
                    .withOpacity(disabled != null && disabled! ? 0.4 : 1),
                const Color.fromARGB(255, 2, 58, 32)
                    .withOpacity(disabled != null && disabled! ? 0.4 : 1),
              ],
              transform: const GradientRotation(0.8),
            )),
        child: Center(
          child: child ??
              Text(
                label ?? "Label",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  height: 1.2,
                  fontWeight: FontWeight.w600,
                ),
              ),
        ),
      ),
    );
  }
}
