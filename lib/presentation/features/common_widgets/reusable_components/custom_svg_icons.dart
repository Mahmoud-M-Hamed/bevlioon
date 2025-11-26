import 'package:bevlioon/presentation/app/resources/resources.dart';

import 'index.dart';

class CustomSvgIcon extends StatelessWidget {
  final String assetPath;
  final String? packageName;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit fit;
  final String? semanticLabel;
  final Alignment alignment;

  const CustomSvgIcon({
    super.key,
    required this.assetPath,
    this.packageName,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
    this.semanticLabel,
    this.alignment = Alignment.center,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      assetPath,
      key: ValueKey(assetPath),
      width: width,
      height: height,
      package: packageName,
      allowDrawingOutsideViewBox: true,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
      alignment: alignment,
      semanticsLabel: semanticLabel,
      placeholderBuilder: (_) => SizedBox(
        width: width,
        height: height,
        child: Center(
          child: CircularProgressIndicator(color: Resources.colors.primary),
        ),
      ),
    );
  }
}
