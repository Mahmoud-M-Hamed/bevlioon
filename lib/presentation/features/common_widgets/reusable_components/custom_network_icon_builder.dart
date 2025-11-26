import '../../app_cache_image/app_cached_image.dart';
import '../../app_cache_image/custom_placeholder_image.dart';
import 'index.dart';

class CustomNetworkImageBuilder extends StatelessWidget {
  final String srcUrl;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? boxFit;
  final String? placeholderAsset;

  const CustomNetworkImageBuilder({
    super.key,
    required this.srcUrl,
    this.color,
    this.height,
    this.width,
    this.boxFit,
    this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    if (srcUrl.toLowerCase().endsWith('.svg')) {
      return SvgPicture.network(
        srcUrl,
        height: height,
        width: width,
        fit: boxFit ?? BoxFit.cover,
        colorFilter: (color != null)
            ? ColorFilter.mode(color!, BlendMode.srcIn)
            : null,
        placeholderBuilder: (_) => CustomPlaceholderImage(
          key: const ValueKey('custom_placeholder_image'),
          height: height,
          width: width,
          path: placeholderAsset,
        ),
      );
    }

    return CustomCachedNetworkImage(
      srcUrl: srcUrl,
      height: height,
      width: width,
    );
  }
}
