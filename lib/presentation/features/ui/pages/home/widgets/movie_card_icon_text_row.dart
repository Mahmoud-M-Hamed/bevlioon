import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';

class MovieCardIconTextRow extends StatelessWidget {
  const MovieCardIconTextRow({
    super.key,
    required this.icon,
    required this.text,
    this.style,
    this.iconColor,
  });

  final IconData icon;
  final String text;
  final TextStyle? style;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: Resources.iconSizes.$18,
          color: iconColor ?? Resources.colors.grayMedium,
        ),
        SizedBox(width: Resources.horizontalDims.$5),
        AppText(text: text, style: style),
      ],
    );
  }
}
