import 'dart:io';

import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/extensions/context_extensions.dart';

import 'index.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Resources.colors.grayUltraLight,
      borderRadius: BorderRadius.circular(Resources.radius.$r8),
      child: InkWell(
        onTap: onTap ?? () => context.safePop,
        borderRadius: BorderRadius.circular(Resources.radius.$r8),
        child: Padding(
          padding: EdgeInsets.all(Resources.horizontalDims.$7),
          child: Icon(
            Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios,
            color: Resources.colors.black,
            size: Resources.iconSizes.$18,
          ),
        ),
      ),
    );
  }
}
