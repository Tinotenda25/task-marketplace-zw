// lib/widgets/common_widgets.dart
import 'package:flutter/material.dart';
import '../config/theme.dart';

class AppAvatar extends StatelessWidget {
  final String initials;
  final Color backgroundColor;
  final double size;
  final TextStyle? textStyle;

  const AppAvatar({
    required this.initials,
    required this.backgroundColor,
    this.size = 38,
    this.textStyle,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          initials,
          style: textStyle ??
              TextStyle(
                color: Colors.white,
                fontSize: size * 0.35,
                fontWeight: FontWeight.w700,
              ),
        ),
      ),
    );
  }
}

class AppBadge extends StatelessWidget {
  final String label;
  final Color color;
  final Color? backgroundColor;

  const AppBadge({
    required this.label,
    this.color = AppColors.primary,
    this.backgroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: backgroundColor ?? Color.fromARGB(24, color.red, color.green, color.blue),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

enum ButtonVariant { primary, secondary, accent, ghost, danger }

class AppButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final ButtonVariant variant;
  final double? width;
  final EdgeInsets padding;
  final double borderRadius;
  final bool isLoading;

  const AppButton({
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.width,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
    this.borderRadius = 12,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton> {
  bool _isPressed = false;

  Color get _backgroundColor {
    switch (widget.variant) {
      case ButtonVariant.primary:
        return AppColors.primary;
      case ButtonVariant.secondary:
        return AppColors.primaryPale;
      case ButtonVariant.accent:
        return AppColors.accent;
      case ButtonVariant.ghost:
        return Colors.transparent;
      case ButtonVariant.danger:
        return AppColors.danger;
    }
  }

  Color get _foregroundColor {
    switch (widget.variant) {
      case ButtonVariant.primary:
      case ButtonVariant.accent:
      case ButtonVariant.danger:
        return Colors.white;
      case ButtonVariant.secondary:
        return AppColors.primary;
      case ButtonVariant.ghost:
        return AppColors.primary;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width ?? double.infinity,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : widget.onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: _backgroundColor,
          foregroundColor: _foregroundColor,
          padding: widget.padding,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius),
            side: widget.variant == ButtonVariant.ghost
                ? const BorderSide(color: AppColors.primary, width: 1.5)
                : BorderSide.none,
          ),
          elevation: 0,
        ),
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
              )
            : Text(
                widget.text,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }
}

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color backgroundColor;
  final double borderRadius;
  final VoidCallback? onTap;
  final BoxBorder? border;

  const AppCard({
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin = const EdgeInsets.only(bottom: 12),
    this.backgroundColor = AppColors.white,
    this.borderRadius = 16,
    this.onTap,
    this.border,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: border,
        ),
        child: child,
      ),
    );
  }
}

class AppInput extends StatelessWidget {
  final String? label;
  final String placeholder;
  final TextEditingController controller;
  final TextInputType inputType;
  final bool obscureText;
  final String? icon;
  final int maxLines;
  final ValueChanged<String>? onChanged;

  const AppInput({
    this.label,
    required this.placeholder,
    required this.controller,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.maxLines = 1,
    this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(
              label!,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: AppColors.mid,
              ),
            ),
          ),
        TextField(
          controller: controller,
          keyboardType: inputType,
          obscureText: obscureText,
          maxLines: maxLines,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: placeholder,
            prefixText: icon != null ? '  ' : null,
            prefixIcon: icon != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 12, right: 8),
                    child: Text(icon!),
                  )
                : null,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
        const SizedBox(height: 14),
      ],
    );
  }
}
