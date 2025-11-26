import 'package:bevlioon/presentation/features/common_widgets/custom_loading_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

import 'custom_placeholder_image.dart';

class CustomCacheManager {
  static const key = 'bevlioon_image_cache_database_key';
  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 30),
      maxNrOfCacheObjects: 500,
      repo: JsonCacheInfoRepository(databaseName: key),
      fileService: HttpFileService(),
    ),
  );
}

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({
    super.key,
    required this.srcUrl,
    this.width,
    this.height,
    this.placeholderPath,
    this.boxFit = BoxFit.cover,
  });

  final String srcUrl;
  final String? placeholderPath;
  final double? width;
  final double? height;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;

    final memCacheWidth = width != null
        ? (width! * devicePixelRatio).toInt()
        : null;
    final memCacheHeight = height != null
        ? (height! * devicePixelRatio).toInt()
        : null;

    return CachedNetworkImage(
      key: ValueKey(srcUrl),
      imageUrl: srcUrl,
      cacheManager: CustomCacheManager.instance,
      width: width,
      height: height,
      fit: boxFit,
      memCacheWidth: memCacheWidth,
      memCacheHeight: memCacheHeight,
      progressIndicatorBuilder: (_, __, ___) => const CustomLoadingWidget(),
      errorWidget: (_, __, ___) => CustomPlaceholderImage(
        key: const ValueKey('placeholder_image_cache_key'),
        width: width,
        height: height,
        path: placeholderPath,
      ),
    );
  }
}
