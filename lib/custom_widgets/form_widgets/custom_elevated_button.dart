part of 'form_widgets.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    this.title = '',
    this.hasIcon = false,
    this.icon,
    this.iconColor,
    this.iconSize,
    this.buttonColor,
    this.border,
    this.fontColor,
    this.fontSize,
    this.width,
    this.height,
    this.radius,
    this.padding,
    this.onTap,
    this.borderWidth,
    this.borderColor,
    this.isLeft = true,
  });

  final String title;
  final bool hasIcon;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  final Color? buttonColor;
  final BorderSide? border;
  final Color? fontColor;
  final double? fontSize;
  final double? width;
  final double? height;
  final double? radius;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? borderWidth;
  final Color? borderColor;
  final bool isLeft;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: buttonColor,
          gradient:
              buttonColor == null
                  ? KineticEnergyColorTheme().primaryGradient
                  : null,
          borderRadius: BorderRadius.circular(radius ?? 32),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
            width: borderWidth ?? 1,
          ),
        ),
        child: Padding(
          padding:
              padding ??
              const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child:
              hasIcon
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        isLeft
                            ? [
                              Icon(
                                icon,
                                color:
                                    iconColor ??
                                    KineticEnergyColorTheme().white,
                                size: iconSize ?? 24,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                title,
                                style: context.bodyText.copyWith(
                                  color:
                                      fontColor ??
                                      KineticEnergyColorTheme().white,
                                  fontSize: fontSize ?? 18,
                                ),
                              ),
                            ]
                            : [
                              Text(
                                title,
                                style: context.bodyText.copyWith(
                                  color:
                                      fontColor ??
                                      KineticEnergyColorTheme().white,
                                  fontSize: fontSize ?? 18,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Icon(
                                icon,
                                color:
                                    iconColor ??
                                    KineticEnergyColorTheme().white,
                                size: iconSize ?? 24,
                              ),
                            ],
                  )
                  : Text(
                    title,
                    style: context.bodyText.copyWith(
                      color: fontColor ?? KineticEnergyColorTheme().white,
                      fontSize: fontSize ?? 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
        ),
      ),
    );
  }
}
