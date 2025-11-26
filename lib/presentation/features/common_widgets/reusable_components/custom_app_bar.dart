import 'package:bevlioon/presentation/app/navigation/app_route_enum.dart';
import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:bevlioon/utils/extensions/navigation_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';

import '../app_text.dart';
import 'index.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    super.key,
    required BuildContext context,
    String? titleText,
    Widget? titleWidget,
    bool super.centerTitle = true,
    Color super.backgroundColor = Colors.white,
    double? elevation,
    bool showBackButton = true,
    bool showActionButton = false,
    void Function()? onBackPressed,
    void Function()? onActionButtonPressed,
  }) : super(
         scrolledUnderElevation: 0,
         elevation: elevation ?? 0,
         leadingWidth: Resources.horizontalDims.$60,
         leading: showBackButton
             ? Padding(
                 padding: EdgeInsetsDirectional.only(
                   start: Resources.horizontalDims.$8,
                   bottom: Resources.verticalDims.$5,
                   top: Resources.verticalDims.$5,
                 ),
                 child: Align(
                   alignment: AlignmentDirectional.center,
                   child: CustomBackButton(onTap: onBackPressed),
                 ),
               )
             : null,
         actions: (showActionButton)
             ? [
                 Padding(
                   padding: EdgeInsetsDirectional.only(
                     end: Resources.horizontalDims.$15,
                     bottom: Resources.verticalDims.$5,
                     top: Resources.verticalDims.$5,
                   ),
                   child: Align(
                     alignment: AlignmentDirectional.center,
                     child: IconButton(
                       onPressed: () =>
                           context.push(AppRouteEnum.favoriteMoviesPage.name),
                       icon: Icon(Icons.favorite, color: Resources.colors.red),
                     ),
                   ),
                 ),
               ]
             : null,
         title:
             titleWidget ??
             AppText(
               text: titleText ?? AppConstants.emptyString,
               style: context.theme.textTheme.labelSmall,
             ),
       );
}
