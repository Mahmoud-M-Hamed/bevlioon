import 'package:bevlioon/presentation/app/resources/resources.dart';
import 'package:bevlioon/utils/extensions/non_null_extension.dart';
import 'package:bevlioon/utils/extensions/theme_extension.dart';
import 'package:flutter/services.dart';

import 'index.dart';

class CustomTextField extends StatelessWidget {
  final String? separatedLabel;
  final String? initialValue;
  final TextStyle? separatedLabelTextStyle;
  final TextStyle? hintTextStyle;
  final String? hintText;
  final String? labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final int maxLines;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final Widget? prefixWidget;
  final Widget? suffixIcon;
  final Widget? suffixWidget;
  final bool? prefixIconConstraints;
  final bool? suffixIconConstraints;
  final VoidCallback? onSuffixTap;
  final bool readOnly;
  final bool filled;
  final bool? mandatoryLabel;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    super.key,
    this.separatedLabel,
    this.initialValue,
    this.separatedLabelTextStyle,
    this.mandatoryLabel,
    this.controller,
    this.hintText,
    this.hintTextStyle,
    this.labelText,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.focusNode,
    this.onChanged,
    this.validator,
    this.prefixIcon,
    this.suffixIcon,
    this.prefixWidget,
    this.suffixWidget,
    this.onSuffixTap,
    this.prefixIconConstraints,
    this.suffixIconConstraints,
    this.readOnly = false,
    this.filled = false,
    this.inputFormatters,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle? defaultSeparatedLabelTextStyle = context
        .textTheme
        .bodyLarge
        ?.copyWith(color: Resources.colors.grayMedium);

    final TextStyle? separatedLabelTextStyle =
        this.separatedLabelTextStyle ?? defaultSeparatedLabelTextStyle;

    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Resources.radius.$r16),
      borderSide: BorderSide(color: Resources.colors.grayLight),
    );

    final OutlineInputBorder errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(Resources.radius.$r16),
      borderSide: BorderSide(color: Resources.colors.red),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (separatedLabel.isNotNullOrEmpty)
          Text(separatedLabel.orEmpty, style: separatedLabelTextStyle),
        if (separatedLabel.isNotNullOrEmpty)
          Resources.verticalDims.$6.verticalSpace,
        TextFormField(
          key: key,
          initialValue: initialValue,
          controller: controller,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onChanged: onChanged,
          validator: validator,
          readOnly: readOnly,
          inputFormatters: inputFormatters,
          style: context.textTheme.headlineMedium,
          decoration: InputDecoration(
            hintText: hintText,
            labelText: separatedLabel == null ? labelText : null,
            hintStyle: hintTextStyle,
            prefixIcon: prefixIcon,
            prefix: prefixWidget,
            prefixIconConstraints: (prefixIconConstraints.orFalse)
                ? BoxConstraints(
                    maxHeight: Resources.verticalDims.$50,
                    maxWidth: Resources.horizontalDims.$50,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? GestureDetector(onTap: onSuffixTap, child: suffixIcon)
                : null,
            suffix: suffixWidget,
            suffixIconConstraints: (suffixIconConstraints.orFalse)
                ? BoxConstraints(
                    maxHeight: Resources.verticalDims.$40,
                    maxWidth: Resources.horizontalDims.$70,
                  )
                : null,
            isDense: true,
            contentPadding: EdgeInsetsDirectional.symmetric(
              vertical: Resources.verticalDims.$12,
              horizontal: Resources.horizontalDims.$16,
            ),
            filled: filled,
            fillColor: Resources.colors.white,
            border: border,
            enabledBorder: border,
            focusedBorder: border,
            errorBorder: errorBorder,
            focusedErrorBorder: errorBorder,
            errorStyle: context.textTheme.labelSmall?.copyWith(
              color: Resources.colors.red,
            ),
          ),
        ),
      ],
    );
  }
}
