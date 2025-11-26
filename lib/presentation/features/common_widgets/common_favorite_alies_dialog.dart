import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/presentation/features/common_widgets/app_text.dart';
import 'package:bevlioon/presentation/features/common_widgets/reusable_components/custom_button.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_dialog_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_dialog_state.dart';
import 'package:bevlioon/utils/extensions/localization_extension.dart';
import 'package:bevlioon/utils/extensions/navigation_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommonFavoriteAliesDialog {
  static Future<String?> showFavoriteDialog(BuildContext context) async {
    final alias = await showDialog<String>(
      context: context,
      builder: (_) => const _FavoriteDialog(),
    );

    return alias;
  }
}

class _FavoriteDialog extends StatelessWidget {
  const _FavoriteDialog();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteDialogCubit(),
      child: BlocBuilder<FavoriteDialogCubit, FavoriteDialogState>(
        builder: (context, state) {
          final cubit = context.read<FavoriteDialogCubit>();
          final textTheme = context.textTheme;
          final localization = context.localization;

          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Resources.radius.$r16),
            ),
            elevation: Resources.elevation.$e8,
            backgroundColor: Resources.colors.dimDarkGray,
            child: Padding(
              padding: EdgeInsetsDirectional.symmetric(
                horizontal: Resources.horizontalDims.$20,
                vertical: Resources.verticalDims.$18,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: localization.addFavorite,
                    style: textTheme.titleMedium?.copyWith(
                      color: Resources.colors.white,
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$15),
                  TextField(
                    onChanged: cubit.onTextChanged,
                    maxLength: 25,
                    style: textTheme.bodyMedium?.copyWith(
                      color: Resources.colors.white,
                    ),
                    cursorColor: Resources.colors.primary,
                    decoration: InputDecoration(
                      hintText: localization.enterAlias,
                      hintStyle: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: Resources.fontWeights.semiBold,
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade800,
                      counterStyle: textTheme.bodyMedium?.copyWith(
                        color: Colors.grey.shade500,
                        fontWeight: Resources.fontWeights.semiBold,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          Resources.radius.$r12,
                        ),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  SizedBox(height: Resources.verticalDims.$20),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: state.isButtonEnabled ? 1 : 0.5,
                    child: CustomButton.text(
                      foregroundColor: state.isButtonEnabled
                          ? Resources.colors.primary
                          : Colors.grey.shade500,
                      onPressed: state.isButtonEnabled
                          ? () => context.pop(state.alias)
                          : null,
                      child: AppText(text: localization.add),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
