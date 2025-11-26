import 'package:bevlioon/presentation/app/navigation/app_route_enum.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/extensions/navigation_extension.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  static const String routeName = 'SplashPage';
  static const String routePath = '/SplashPage';

  @override
  Widget build(BuildContext context) {
    //TODO:  Navigate according to state (Success State)
    //TODO:  Dependent on state & navigate to different pages
    Future.delayed(const Duration(seconds: 5), () {
      if (context.mounted) {
        context.pushReplacement(AppRouteEnum.homePage.name);
      }
    });

    return Scaffold(
      backgroundColor: Resources.colors.primary,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: Resources.gradientColors.primaryLimeGradient,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              Resources.drawables.bevlioonLogoImage,
              width: Resources.horizontalDims.$206,
            ),
          ],
        ),
      ),
    );
  }
}
