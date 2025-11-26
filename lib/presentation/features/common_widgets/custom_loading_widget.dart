import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/index.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: CircularProgressIndicator(
        color: color ?? Resources.colors.primary,
      ),
    );
  }
}
