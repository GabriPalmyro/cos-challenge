import 'package:cos_challenge/app/design/tokens/cos_fonts.dart';
import 'package:cos_challenge/app/design/tokens/tokens.dart';
import 'package:flutter/material.dart';

enum CosButtonType {
  primary,
  secondary,
}

enum CosButtonSize {
  small,
  medium,
  large,
}

class CosButton extends StatelessWidget {
  const CosButton({
    required this.label,
    this.type = CosButtonType.primary,
    this.size = CosButtonSize.medium,
    this.onPressed,
    super.key,
  });

  final String label;
  final CosButtonType type;
  final CosButtonSize size;
  final VoidCallback? onPressed;

  Color get _buttonColor {
    switch (type) {
      case CosButtonType.primary:
        return CosColors.primary;
      case CosButtonType.secondary:
        return CosColors.secondary;
    }
  }

  Color get _textColor {
    switch (type) {
      case CosButtonType.primary:
        return CosColors.secondary;
      case CosButtonType.secondary:
        return CosColors.primary;
    }
  }

  double get _buttonHeight {
    switch (type) {
      case CosButtonType.primary:
        return 48.0;
      case CosButtonType.secondary:
        return 40.0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: _buttonHeight,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: _buttonColor,
          borderRadius: BorderRadius.circular(CosBorder.radiusSmall),
        ),
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                color: _textColor,
                fontSize: CosFonts.medium,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
