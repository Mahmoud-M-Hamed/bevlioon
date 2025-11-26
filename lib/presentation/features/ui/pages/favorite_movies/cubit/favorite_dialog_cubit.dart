import 'package:flutter_bloc/flutter_bloc.dart';

import 'favorite_dialog_state.dart';

class FavoriteDialogCubit extends Cubit<FavoriteDialogState> {
  FavoriteDialogCubit() : super(const FavoriteDialogState.initial());

  void onTextChanged(String value) {
    final alias = value.trim();
    final isValidAlias = alias.length >= 3 && alias.length <= 25;
    emit(state.copyWith(alias: alias, isButtonEnabled: isValidAlias));
  }
}
