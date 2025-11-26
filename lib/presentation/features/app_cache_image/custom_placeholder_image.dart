import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:flutter/material.dart';

/// opt(MY): Please move this to the core module (Done)
class CustomPlaceholderImage extends StatelessWidget {
  const CustomPlaceholderImage({
    super.key,
    required this.width,
    required this.height,
    required this.path,
  });

  final double? width;
  final double? height;
  final String? path;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      key: key,
      path ?? Resources.drawables.bevlioonLogoImage,
      width: width,
      height: height,
      fit: BoxFit.cover,
    );
  }
}
