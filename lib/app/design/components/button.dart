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
    this.isLoading = false,
    this.onPressed,
    super.key,
  });

  final String label;
  final CosButtonType type;
  final CosButtonSize size;
  final VoidCallback? onPressed;
  final bool isLoading;

  Color get _buttonColor {
    switch (type) {
      case CosButtonType.primary:
        return CosColors.primary;
      case CosButtonType.secondary:
        return CosColors.transparent;
    }
  }

  Color get _textColor {
    switch (type) {
      case CosButtonType.primary:
        return CosColors.background;
      case CosButtonType.secondary:
        return CosColors.primary;
    }
  }

  double get _buttonHeight {
    switch (size) {
      case CosButtonSize.large:
        return 48.0;
      case CosButtonSize.medium:
        return 40.0;
      case CosButtonSize.small:
        return 32.0;
    }
  }

  Border? get _buttonBorder {
    if (type == CosButtonType.primary) {
      return null;
    }

    return Border.all(
      color: CosColors.primary,
      width: CosBorder.width,
    );
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
          border: _buttonBorder,
        ),
        child: GestureDetector(
          onTap: onPressed,
          behavior: HitTestBehavior.opaque,
          child: Center(
            child: isLoading
                ? SizedBox.fromSize(
                    size: Size.square(_buttonHeight * 0.4),
                    child: CircularProgressIndicator(
                      color: _textColor,
                    ),
                  )
                : Text(
                    label,
                    style: TextStyle(
                      color: _textColor,
                      fontWeight: FontWeight.w600,
                      fontSize: CosFonts.medium,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
