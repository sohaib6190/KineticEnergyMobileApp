part of 'form_widgets.dart';

class GradientCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;

  const GradientCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onChanged(!value);
      },
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(4),
          gradient:
              value
                  ? LinearGradient(
                    colors: [
                      KineticEnergyColorTheme().primaryGradient1,
                      KineticEnergyColorTheme().primaryGradient2,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                  : null,
          color:
              value
                  ? null
                  : KineticEnergyColorTheme()
                      .white, // Set color to white when unchecked
          border: Border.all(
            color:
                KineticEnergyColorTheme()
                    .black20, // Border color when unchecked
            width: 2,
          ),
        ),
        child:
            value
                ? Icon(
                  Icons.check,
                  color: KineticEnergyColorTheme().white,
                  size: 18,
                )
                : null,
      ),
    );
  }
}
