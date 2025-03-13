part of 'form_widgets.dart';

class CustomDropDown<T> extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.options = const [],
    this.value,
    this.onChanged,
    this.isDense = true,
    this.filled = false,
    this.fillColor,
    this.dropdownColor,
    this.suffixIcon,
    this.prefixIcon,
    this.enabledBorder,
    this.focusedBorder,
    this.contentPadding,
    this.style,
    this.hintText,
    this.hintStyle,
    this.expandIconColor,
    this.error,
  });

  final List<CustomDropDownOption<T>> options;
  final T? value;
  final ValueChanged<T?>? onChanged;
  final bool? isDense;
  final bool? filled;
  final Color? fillColor;
  final Color? dropdownColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? style;
  final String? hintText;
  final TextStyle? hintStyle;
  final Color? expandIconColor;
  final Widget? error;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      hint: Text(
        '$hintText',
        style:
            hintStyle ??
            context.bodyText.copyWith(
              fontSize: 14,
              color: context.monochromeColor.withValues(alpha: 0.5),
            ),
      ),
      isExpanded: false,
      dropdownColor:
          dropdownColor ??
          (context.isDarkTheme
              ? KineticEnergyColorTheme().secondary
              : KineticEnergyColorTheme().white),
      borderRadius: BorderRadius.circular(16),
      icon: Icon(
        Icons.expand_more,
        color: expandIconColor ?? KineticEnergyColorTheme().white,
      ),
      items:
          options.map((option) {
            return DropdownMenuItem(
              value: option.value,
              child: Text(
                option.displayOption,
                style: context.bodyText.copyWith(fontSize: 14),
                overflow: TextOverflow.ellipsis,
              ),
            );
          }).toList(),
      decoration: InputDecoration(
        filled: filled,
        fillColor:
            fillColor ??
            (context.isDarkTheme
                ? KineticEnergyColorTheme().secondary
                : KineticEnergyColorTheme().lightGrey),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon,
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
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.red),
        ),
        isDense: isDense,
        contentPadding:
            contentPadding ?? const EdgeInsets.fromLTRB(16, 12, 16, 12),
        error: error,
      ),
      style: style ?? context.bodyText,
      value: value,
      onChanged: onChanged,
    );
  }
}

class CustomDropDownOption<T> {
  final T value;
  final String displayOption;

  const CustomDropDownOption({
    required this.value,
    required this.displayOption,
  });
}
