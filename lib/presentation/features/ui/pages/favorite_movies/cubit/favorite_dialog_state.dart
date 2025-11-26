import 'package:bevlioon/utils/constants/app_constants.dart';
import 'package:equatable/equatable.dart';

class FavoriteDialogState extends Equatable {
  final String alias;
  final bool isButtonEnabled;

  const FavoriteDialogState({
    required this.alias,
    required this.isButtonEnabled,
  });

  const FavoriteDialogState.initial()
    : alias = AppConstants.emptyString,
      isButtonEnabled = false;

  FavoriteDialogState copyWith({String? alias, bool? isButtonEnabled}) =>
      FavoriteDialogState(
        alias: alias ?? this.alias,
        isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      );

  @override
  List<Object?> get props => [alias, isButtonEnabled];
}
