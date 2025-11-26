import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_dialog_cubit.dart';
import 'package:bevlioon/presentation/features/ui/pages/favorite_movies/cubit/favorite_dialog_state.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('FavoriteDialogCubit', () {
    late FavoriteDialogCubit cubit;

    setUp(() {
      cubit = FavoriteDialogCubit();
    });

    tearDown(() {
      cubit.close();
    });

    test('initial state is correct', () {
      expect(cubit.state, const FavoriteDialogState.initial());
    });

    test('onTextChanged updates state with new text', () {
      const testText = 'Test Note';
      cubit.onTextChanged(testText);
      expect(cubit.state.alias, testText);
    });

    test('emits states when alias changes and validates correctly', () async {
      final states = <FavoriteDialogState>[];
      final sub = cubit.stream.listen(states.add);

      cubit.onTextChanged('alies');
      cubit.onTextChanged('alies2');
      cubit.onTextChanged('');

      await Future.delayed(Duration.zero);

      expect(states, [
        const FavoriteDialogState(alias: 'alies', isButtonEnabled: true),
        const FavoriteDialogState(alias: 'alies2', isButtonEnabled: true),
        const FavoriteDialogState(alias: '', isButtonEnabled: false),
      ]);

      await sub.cancel();
    });

    test('onTextChanged with empty alias disables button and emits state', () async {
      final states = <FavoriteDialogState>[];
      final sub = cubit.stream.listen(states.add);
      cubit.onTextChanged('');

      await Future.delayed(Duration.zero);

      expect(states, [
        const FavoriteDialogState(alias: '', isButtonEnabled: false),
      ]);
      await sub.cancel();
    });
  });
}

