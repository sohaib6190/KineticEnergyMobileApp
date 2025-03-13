part of 'form_widgets.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    TextEditingController? controller,
    this.enabled = true,
    this.initialValue,
    this.obscureText = false,
    this.inputFormatters,
    this.onChanged,
    this.onTap,
    this.filled = true,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.prefixText,
    this.prefixStyle,
    this.suffixIconColor,
    this.suffixIconSize,
    this.suffixIconConstraints,
    this.error,
    this.labelText,
    this.labelStyle,
    this.hintText,
    this.hintStyle,
    this.enabledBorder,
    this.focusedBorder,
    this.errorBorder,
    this.focusedErrorBorder,
    this.isDense = true,
    this.readOnly = false,
    this.alignLabelWithText,
    this.maxLines = 1,
    this.minLines,
    this.keyboardType,
    this.border,
    this.contentPadding,
    this.contentStyle,
    this.focusNode,
    this.onFieldSubmitted,
    this.validator,
    this.onTapOutside,
  }) : _controller = controller;

  final TextEditingController? _controller;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool filled;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final BoxConstraints? suffixIconConstraints;
  final Widget? error;
  final String? labelText;
  final TextStyle? labelStyle;
  final String? hintText;
  final TextStyle? hintStyle;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? errorBorder;
  final InputBorder? focusedErrorBorder;
  final bool isDense;
  final bool readOnly;
  final bool? alignLabelWithText;
  final int? maxLines;
  final int? minLines;
  final TextInputType? keyboardType;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? contentStyle;
  final FocusNode? focusNode;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final Function(PointerDownEvent)? onTapOutside;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTapOutside:
          onTapOutside ?? (_) => FocusManager.instance.primaryFocus?.unfocus(),
      enabled: enabled,
      initialValue: initialValue,
      obscureText: obscureText,
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        filled: filled,
        fillColor: fillColor ?? KineticEnergyColorTheme().secondary,
        border: border,
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.transparent),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: KineticEnergyColorTheme().red),
            ),
        focusedErrorBorder:
            focusedErrorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: KineticEnergyColorTheme().red),
            ),
        error: error,
        hintText: hintText,
        hintStyle:
            hintStyle ??
            context.bodyText.copyWith(
              color: context.monochromeColor.withValues(alpha: 0.4),
            ),
        isDense: isDense,
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
        prefixText: prefixText,
        prefixStyle: prefixStyle ?? context.bodyText,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(16, 12, 16, 12),
        suffixIconConstraints: suffixIconConstraints,
        labelText: labelText,
        labelStyle:
            labelStyle ??
            context.bodyText.copyWith(
              color: context.monochromeColor.withValues(alpha: 0.7),
            ),
        alignLabelWithHint: alignLabelWithText,
      ),
      onTap: onTap,
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: _controller,
      onChanged: onChanged,
      focusNode: focusNode,
      validator: validator,
      style: contentStyle ?? context.bodyText,
      maxLines: maxLines,
      minLines: minLines,
    );
  }
}
